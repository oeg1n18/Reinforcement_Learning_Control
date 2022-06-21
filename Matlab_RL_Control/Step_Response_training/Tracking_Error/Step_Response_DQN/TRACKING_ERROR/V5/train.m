
% Training Parameters 
max_iteration = 1000; 
batch_size = 32; 
weights_copy_frequency = 15; 
batch_size = 32; 
train_frequency = 8;

G = tf([1,5], [1,2,3]);


deltas = [0.1,0.25,0.5];

% ===============================================================
% Create the Environment 
env = Environment(G, [10,1,1]);
env.delta = deltas(1);

% Create dqn agent 
% 3 state vars, 7 possible actions, [24,10] Neural network layers
dqn1 = DQN(3, 7, [24], 1, max_iteration);

% Data Collection 
reward1_hist = zeros(1, max_iteration); 
Mp1_hist = zeros(1, max_iteration); 
ts1_hist = zeros(1, max_iteration); 
tr1_hist = zeros(1, max_iteration);

for iter = 1:max_iteration
    dqn1.epsilon
    env.delta = deltas(1);
    state = env.state;
    action = dqn1.action(env.state);
    [reward, next_state] = env.step(action);
    if state(1) ~= inf
        dqn1.store(state, action, reward, next_state);
    end
    if mod(iter, train_frequency) == 0
        dqn1.experience_replay(batch_size);
    end
    
    reward1_hist(iter) = reward; 
    Mp1_hist(iter) = state(1);
    ts1_hist(iter) = state(2);
    tr1_hist(iter) = state(3);
end
    


% ===============================================================
% Create the Environment 
env = Environment(G, [10,1,1]);
env.delta = deltas(2);

% Create dqn agent 
% 3 state vars, 7 possible actions, [24,10] Neural network layers
dqn2 = DQN(3, 7, [24], 1, max_iteration);

% Data Collection 
reward2_hist = zeros(1, max_iteration); 
Mp2_hist = zeros(1, max_iteration); 
ts2_hist = zeros(1, max_iteration); 
tr2_hist = zeros(1, max_iteration);

for iter = 1:max_iteration
    iter
    env.delta = deltas(2);
    state = env.state;
    action = dqn2.action(env.state);
    [reward, next_state] = env.step(action);
    if state(1) ~= inf
        dqn2.store(state, action, reward, next_state);
    end
    if mod(iter, train_frequency) == 0
        dqn2.experience_replay(batch_size);
    end
    
    reward2_hist(iter) = reward; 
    Mp2_hist(iter) = state(1);
    ts2_hist(iter) = state(2);
    tr2_hist(iter) = state(3);
end
    
% ===============================================================
% Create the Environment 
env = Environment(G, [10,1,1]);
env.delta = deltas(3);

% Create dqn agent 
% 3 state vars, 7 possible actions, [24,10] Neural network layers
dqn3 = DQN(3, 7, [24], 1, max_iteration);

% Data Collection 
reward3_hist = zeros(1, max_iteration); 
Mp3_hist = zeros(1, max_iteration); 
ts3_hist = zeros(1, max_iteration); 
tr3_hist = zeros(1, max_iteration);

for iter = 1:max_iteration
    dqn3.epsilon
    env.delta = deltas(3);
    state = env.state;
    action = dqn3.action(env.state);
    [reward, next_state] = env.step(action);
    reward;
    if state(1) ~= inf
        dqn3.store(state, action, reward, next_state);
    end
    if mod(iter, train_frequency) == 0
        dqn3.experience_replay(batch_size);
    end
    
    reward3_hist(iter) = reward; 
    Mp3_hist(iter) = state(1);
    ts3_hist(iter) = state(2);
    tr3_hist(iter) = state(3);
end




% Plotting
subplot(2,2,1);
hold on 
plot(reward1_hist);
plot(reward2_hist);
plot(reward3_hist);
title('Reward','FontSize',18)
xlabel('Iteration','FontSize',14);
legend('Delta1', 'Delta2', 'Delta3');

subplot(2,2,2); 
hold on 
plot(Mp1_hist);
plot(Mp2_hist);
plot(Mp3_hist);
title('Overshoot','FontSize',18)
ylabel('Mp (%)','FontSize',14);
xlabel('Iteration','FontSize',14);
legend('Delta1', 'Delta2', 'Delta3');

subplot(2,2,3) 
hold on 
plot(tr1_hist);
plot(tr2_hist);
plot(tr3_hist);
title('Rise Time','FontSize',18); 
xlabel('Iteration','FontSize',14);
ylabel('Rise Time','FontSize',14);
legend('Delta1', 'Delta2', 'Delta3');
subplot(2,2,4);
hold on 
plot(ts1_hist);
plot(ts2_hist);
plot(ts3_hist);
title('Settling Time','FontSize',18)
xlabel('Iteration','FontSize',14);
ylabel('time (s)','FontSize',14);
legend('Delta1', 'Delta2', 'Delta3');
   

