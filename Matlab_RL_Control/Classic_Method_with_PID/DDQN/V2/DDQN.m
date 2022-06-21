classdef DDQN < handle
    %DDQN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        number_state;
        number_actions;
        memory;
        epsilon = 1; 
        epsilon_decay_start; 
        epsilon_decay_finish; 
        epsilon_decay_rate;
        discount_factor = 0.999; 
        agent;
        target;
        loss = 0;
        reward_W = [1,1,1,1]
        epoch = 0;
        max_epochs = 10000;
        training_records;
        action_count = 0;
       
    end
    
    methods
        function obj = DDQN(n_S, n_A, layers, e_start, e_finish)
            %DDQN Construct an instance of this class
            obj.number_state = n_S;
            obj.number_actions = n_A;
            obj.memory = Experience_Replay(n_S);
            obj.agent = makenet(layers);
            obj.target = makenet(layers);
            obj.copy_weights_agent_to_target()
            obj.agent = confignet(obj.agent, rand(n_S, 5), -rand(n_A, 5));
            obj.target = confignet(obj.target, rand(n_S, 5), -rand(n_A, 5));
            obj.agent.trainParam.showWindow=0;
            obj.target.trainParam.showWindow=0;
            obj.training_records = zeros(0, obj.max_epochs);
            obj.epsilon_decay_start = e_start; 
            obj.epsilon_decay_finish = e_finish; 
            
            obj.epsilon_decay_rate = 1/(e_finish - e_start);
            
        end
        
           
        function copy_weights_agent_to_target(obj)
            obj.target.IW = obj.agent.IW; 
            obj.target.LW = obj.agent.LW;
            obj.target.b = obj.agent.b;
        end
        
        
        % take an action according to greedy policy
        function a = action(obj, state)
            obj.action_count = obj.action_count + 1;
            if obj.action_count > obj.epsilon_decay_start
                if obj.action_count < obj.epsilon_decay_finish
                    obj.epsilon = obj.epsilon - obj.epsilon_decay_rate;
                end
            end
            if rand() < obj.epsilon
                a = randi(obj.number_actions);
            else 
                action_vals = obj.agent(transpose(state));
                [~, a] = max(action_vals);
            end  
        end
        
        % take best possible action
        function a = exploit_action(obj, state)
            action_vals = obj.agent(transpose(state));
            [~, a] = max(action_vals);
        end
        
        function store(obj, S, A, R, S1)
            obj.memory.insert_experience(S,A,R,S1);
        end
        
        
        % Train Evaluation Network with estimates from target
        function experience_replay(obj, batch_size) 
           obj.epoch = obj.epoch+1;
           [S, A, R, Sn] = obj.memory.get_batch(batch_size);  
           st_predict = obj.agent(transpose(S));
           nst_predict = obj.agent(transpose(Sn));
           nst_predict_target = obj.target(transpose(Sn));
           Q_target = st_predict; 
           
           for i = 1:batch_size
               [~,next_best_action] = max(nst_predict(:,i));
               Q_target(A(i),i) = R(i) + obj.discount_factor * nst_predict_target(next_best_action,i);
           end

           obj.agent = trainnet(obj.agent, transpose(S), Q_target);
        
           obj.epoch = obj.epoch + 1;
        end
    end
end


function net = makenet(layers)
    net = feedforwardnet(layers);
end

function net = confignet(net, x, t)
    net = configure(net, x, t);
end

function net = trainnet(net, x, t)
        net = train(net, x, t, 'useParallel','no');
end
