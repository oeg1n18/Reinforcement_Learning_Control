
% Training Parameters 
max_iteration = 4000; 
weights_copy_frequency = 15; 
batch_size = 32; 
train_frequency = 8;

% Create the Environment 
G = tf([1,5], [1,2,3]);
envs = [Environment(G, [10,1,1]),Environment(G, [10,1,1]),Environment(G, [10,1,1])];
deltas = [0.5,0.75,1.0];

% Create DDQN agent 
% 3 state vars, 7 possible actions, [24,10] Neural network layers
ddqns = [DDQN(3, 7, [24], 100, max_iteration-100) ,DDQN(3, 7, [24], 100, max_iteration-100), DDQN(3, 7, [24], 100, max_iteration-100)];

% Data Collection 
reward_hist = zeros(3, max_iteration); 
Mp_hist = zeros(3, max_iteration); 
ts_hist = zeros(3, max_iteration); 
tr_hist = zeros(3, max_iteration);


for d_i = 1:3
    env = envs(d_i);
    env.delta = deltas(d_i);
    ddqn = ddqns(d_i);
    for iter = 1:max_iteration
        disp(iter)
        env.delta = deltas(d_i);
        state = env.state;
        action = ddqn.action(env.state);
        [reward, next_state] = env.step(action);

        if state(1) ~= inf
            ddqn.store(state, action, reward, next_state);
        end

        if mod(iter, train_frequency) == 0
            ddqn.experience_replay(batch_size);
        end

        if mod(iter, weights_copy_frequency) == 0
            ddqn.copy_weights_target_to_agent();
        end
        
        reward_hist(d_i,iter) = reward; 
        Mp_hist(d_i,iter) = state(1);
        ts_hist(d_i,iter) = state(2);
        tr_hist(d_i,iter) = state(3);
    end
end
    


   

