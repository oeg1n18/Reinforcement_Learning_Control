clc;
% Training Parameters 
max_iter = 2000;

% Initialised PID parameters 
gains = [10,1,1];

% Transfer Function of Plant
P = tf([1,5], [1,2,3]);

% Create Environment 
% three state variables Mp, ts, tr
% state variables are boolean
% limits for terminal state 
lims = [2.0,7.0,5.0];


deltas = [0.1,0.15,0.15];
% Create Q-learning Agent 
% three state variables Mp, ts, tr
% state variables are boolean
% 7 possible actions 

% For Plotting 
reward1_hist = zeros(1, max_iter); 
Mp1_hist = zeros(1, max_iter);
ts1_hist = zeros(1, max_iter); 
tr1_hist = zeros(1, max_iter);

agent1 = QLearn(3,2,7, 5, max_iter);
env = Environment(P, gains, lims);
env.delta = deltas(3);
steps = 0;
for iter = 1:max_iter
    if mod(iter, 100) == 0
        steps = steps + 100;
        disp("inteations completed: " + string(steps));
    end
    % get current state
    state = env.state;
    % choose action according to greedy policy
    action = agent1.action(env.state);
    % apply action to environment
    [reward, next_state] = env.step(action);
    % update Q-table with reward
    agent1.update_table(state, action, reward, next_state); 
    % Collect data
    reward1_hist(iter) = reward;
    Mp1_hist(iter) = env.Mp;
    ts1_hist(iter) = env.ts;
    tr1_hist(iter) = env.tr;
    % environment automatically transitions
end


% For Plotting 
reward2_hist = zeros(1, max_iter); 
Mp2_hist = zeros(1, max_iter);
ts2_hist = zeros(1, max_iter); 
tr2_hist = zeros(1, max_iter);

agent2 = QLearn(3,2,7, 5, max_iter);
env = Environment(P, gains, lims);
env.delta = deltas(2);
steps = 0;
for iter = 1:max_iter
    if mod(iter, 100) == 0
        steps = steps + 100;
        disp("inteations completed: " + string(steps));
    end
    % get current state
    state = env.state;
    % choose action according to greedy policy
    action = agent2.action(env.state);
    % apply action to environment
    [reward, next_state] = env.step(action);
    % update Q-table with reward
    agent2.update_table(state, action, reward, next_state); 
    % Collect data
    reward2_hist(iter) = reward;
    Mp2_hist(iter) = env.Mp;
    ts2_hist(iter) = env.ts;
    tr2_hist(iter) = env.tr;
    % environment automatically transitions
end

% For Plotting 
reward3_hist = zeros(1, max_iter); 
Mp3_hist = zeros(1, max_iter);
ts3_hist = zeros(1, max_iter); 
tr3_hist = zeros(1, max_iter);

agent3 = QLearn(3,2,7, 5, max_iter);
env = Environment(P, gains, lims);
env.delta = deltas(3);
steps = 0;
for iter = 1:max_iter
    if mod(iter, 100) == 0
        steps = steps + 100;
        disp("inteations completed: " + string(steps));
    end
    % get current state
    state = env.state;
    % choose action according to greedy policy
    action = agent3.action(env.state);
    % apply action to environment
    [reward, next_state] = env.step(action);
    % update Q-table with reward
    agent3.update_table(state, action, reward, next_state); 
    % Collect data
    reward3_hist(iter) = reward;
    Mp3_hist(iter) = env.Mp;
    ts3_hist(iter) = env.ts;
    tr3_hist(iter) = env.tr;
    % environment automatically transitions
end



