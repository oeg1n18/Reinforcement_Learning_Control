classdef QLearn < handle
    %QLEARN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        n_s_v; 
        n_a;
        n_s_bins
        Q;
        epsilon = 1;
        learning_rate = 0.1; 
        discount_factor = 0.999;
        iter;
        e_decay_start; 
        e_decay_finish;
        e_decay_rate;
        state_dimen;
    end
    
    methods
        function obj = QLearn(num_state_variables, state_dimen ,num_actions, epsilon_decay_start, epsilon_decay_finish)
            %QLEARN Construct an instance of this class
            obj.n_s_v = num_state_variables; 
            obj.n_a = num_actions;
            obj.state_dimen = state_dimen;
            obj.e_decay_start = epsilon_decay_start;
            obj.e_decay_finish = epsilon_decay_finish;
            obj.e_decay_rate = 1/(obj.e_decay_finish - obj.e_decay_start);
            obj.iter = 0;
            
            % Create Q-table 
            obj.Q = zeros(obj.state_dimen(1), obj.state_dimen(2), obj.state_dimen(3), obj.n_a);
              
        end
        
        
        
        function a = action(obj,state)
            %METHOD1 Summary of this method goes here
            obj.iter = obj.iter+1;
            if obj.iter > obj.e_decay_start
                if obj.iter < obj.e_decay_finish
                    obj.epsilon = obj.epsilon - obj.e_decay_rate;
                end
            end
            
            if rand() < obj.epsilon
                a = randi(obj.n_a);
            else 
                max_val = -100000;
                max_action = 1;
                for action = 1:obj.n_a
                    index = num2cell(cat(2, state, action));
                    val = obj.Q(index{:});
                    if val > max_val
                        max_action = action;
                        max_val = val;
                    end
                end
                a = max_action;
            end
        end
        
        
        
        function a = exploit_action(obj, state)
            max_val = -100000;
            max_action = 1;
            for action = 1:obj.n_a
                index = num2cell(cat(2, state, action));
                val = obj.Q(index{:});
                if val > max_val
                    max_action = action;
                    max_val = val;
                end
            end
            a = max_action;
        end
        
        
        
        function update_table(obj, S, A, R, Sn)
            next_best_action = obj.exploit_action(Sn);
            index = num2cell(cat(2,S,A));
            next_index = num2cell(cat(2,Sn,next_best_action));
            obj.Q(index{:}) = obj.Q(index{:}) + obj.learning_rate*(R + obj.Q(next_index{:}) - obj.Q(index{:}));
        end
    end
end

