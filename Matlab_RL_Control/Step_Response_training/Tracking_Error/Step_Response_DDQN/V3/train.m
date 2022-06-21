clc;
% Training Parameters 
max_iteration = 10000; 
weights_copy_frequency = 40; 
batch_size = 32; 
train_frequency = 8;

% Create the Environment 
G = tf([1,5], [1,2,3]);

deltas = [0.1,0.25,0.5];


% Create DDQN agent
% 3 state vars, 7 possible actions, [24,10] Neural network layers
% ======================================================================
ddqn1 = DDQN(3, 7, [24], 1, max_iteration);
env = Environment(G, [10,1,1]);
env.delta = deltas(1);

% Data Collection 
reward1_hist = zeros(1, max_iteration); 
Mp1_hist = zeros(1, max_iteration); 
ts1_hist = zeros(1, max_iteration); 
tr1_hist = zeros(1, max_iteration);

for iter = 1:max_iteration
    disp(ddqn1.epsilon)
    env.delta = deltas(2);
    state = env.state;
    action = ddqn1.action(env.state);
    [reward, next_state] = env.step(action);

    if state(1) ~= inf
        ddqn1.store(state, action, reward, next_state);
    end

    if mod(iter, train_frequency) == 0
        ddqn1.experience_replay(batch_size);
    end

    if mod(iter, weights_copy_frequency) == 0
        ddqn1.copy_weights_target_to_agent();
    end

    reward1_hist(iter) = reward; 
    Mp1_hist(iter) = state(1);
    ts1_hist(iter) = state(2);
    tr1_hist(iter) = state(3);
end





% Create DDQN agent
% 3 state vars, 7 possible actions, [24,10] Neural network layers
% ======================================================================
ddqn2 = DDQN(3, 7, [24], 1, max_iteration);
env = Environment(G, [10,1,1]);
env.delta = deltas(2);

% Data Collection 
reward2_hist = zeros(1, max_iteration); 
Mp2_hist = zeros(1, max_iteration); 
ts2_hist = zeros(1, max_iteration); 
tr2_hist = zeros(1, max_iteration);

for iter = 1:max_iteration
    disp(ddqn2.epsilon)
    env.delta = deltas(2);
    state = env.state;
    action = ddqn2.action(env.state);
    [reward, next_state] = env.step(action);

    if state(1) ~= inf
        ddqn2.store(state, action, reward, next_state);
    end

    if mod(iter, train_frequency) == 0
        ddqn2.experience_replay(batch_size);
    end

    if mod(iter, weights_copy_frequency) == 0
        ddqn2.copy_weights_target_to_agent();
    end

    reward2_hist(1,iter) = reward; 
    Mp2_hist(1,iter) = state(1);
    ts2_hist(1,iter) = state(2);
    tr2_hist(1,iter) = state(3);
end




% Create DDQN agent
% 3 state vars, 7 possible actions, [24,10] Neural network layers
% ======================================================================
ddqn3 = DDQN(3, 7, [24], 1, max_iteration);
env = Environment(G, [10,1,1]);
env.delta = deltas(3);

% Data Collection 
reward3_hist = zeros(1, max_iteration); 
Mp3_hist = zeros(1, max_iteration); 
ts3_hist = zeros(1, max_iteration); 
tr3_hist = zeros(1, max_iteration);

for iter = 1:max_iteration
    disp(ddqn3.epsilon)
    env.delta = deltas(3);
    state = env.state;
    action = ddqn3.action(env.state);
    [reward, next_state] = env.step(action);

    if state(1) ~= inf
        ddqn3.store(state, action, reward, next_state);
    end

    if mod(iter, train_frequency) == 0
        ddqn3.experience_replay(batch_size);
    end

    if mod(iter, weights_copy_frequency) == 0
        ddqn3.copy_weights_target_to_agent();
    end

    reward3_hist(1,iter) = reward; 
    Mp3_hist(1,iter) = state(1);
    ts3_hist(1,iter) = state(2);
    tr3_hist(1,iter) = state(3);
end
    


   

