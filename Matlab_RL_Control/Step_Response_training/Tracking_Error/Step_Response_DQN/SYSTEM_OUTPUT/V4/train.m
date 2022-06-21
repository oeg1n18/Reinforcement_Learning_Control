
% Training Parameters 
max_iteration = 4000; 
batch_size = 32; 
weights_copy_frequency = 15; 
batch_size = 32; 
train_frequency = 8;


% Create the Environment 
G = tf([1,5], [1,2,3]);
envs = [Environment(G, [10,1,1]),Environment(G, [10,1,1]),Environment(G, [10,1,1])];
deltas = [0.1,0.25,0.5];



% Create dqn agent 
% 3 state vars, 7 possible actions, [24,10] Neural network layers
dqns = [DQN(3, 7, 24, 1, max_iteration),DQN(3, 7, 24, 1, max_iteration),DQN(3, 7, 24, 1, max_iteration)];


% Data Collection 
reward_hist = zeros(1, max_iteration); 
Mp_hist = zeros(3, max_iteration); 
ts_hist = zeros(3, max_iteration); 
tr_hist = zeros(3, max_iteration);


for d_i = 1:3
    dqn = dqns(d_i); 
    env = envs(d_i); 
    env.delta = deltas(d_i);
    for iter = 1:max_iteration
        disp(iter);
        state = env.state;
        action = dqn.action(env.state);
        [reward, next_state] = env.step(action);

        if state(1) ~= inf
            dqn.store(state, action, reward, next_state);
        end

        if mod(iter, train_frequency) == 0
            dqn.experience_replay(batch_size);
        end

        reward_hist(d_i,iter) = reward; 
        Mp_hist(d_i,iter) = state(1);
        ts_hist(d_i,iter) = state(2);
        tr_hist(d_i,iter) = state(3);
    end
end
    




   

