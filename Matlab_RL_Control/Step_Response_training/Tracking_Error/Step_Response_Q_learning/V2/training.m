% Training Parameters 
max_iter = 5000;

% Initialised PID parameters 
gains = [10,1,1];

% Transfer Function of Plant
P = tf([1,5], [1,2,3]);

% Create Environment 
% three state variables Mp, ts, tr
% state variables are boolean
% limits for terminal state 
lims = [2.0,7.0,5.0];
env = Environment(P, gains, lims);
env.reward_weights = [1,1,1];

% Create Q-learning Agent 
% three state variables Mp, ts, tr
% state variables are boolean
% 7 possible actions 
agent = QLearn(3,2,7, 5, max_iter); 

% For Plotting 
reward_hist = zeros(1, max_iter); 
Mp_hist = zeros(1, max_iter);
ts_hist = zeros(1, max_iter); 
tr_hist = zeros(1, max_iter);

for iter = 1:max_iter
    disp(iter);

    % get current state
    state = env.state;

    % choose action according to greedy policy
    action = agent.action(env.state);

    % apply action to environment
    [reward, next_state] = env.step(action);


    % update Q-table with reward
    agent.update_table(state, action, reward, next_state); 

    % Collect data

    reward_hist(iter) = reward;
    Mp_hist(iter) = env.Mp;
    ts_hist(iter) = env.ts;
    tr_hist(iter) = env.tr;

    % environment automatically transitions
end


% Plotting
subplot(2,2,1);
plot(reward_hist);
title('Reward','FontSize',18)
xlabel('Iteration','FontSize',14);

subplot(2,2,2); 
plot(Mp_hist);
title('Overshoot','FontSize',18)
ylabel('Mp (%)','FontSize',14);
xlabel('Iteration','FontSize',14);


subplot(2,2,3) 
plot(tr_hist);
title('Rise Time','FontSize',18); 
xlabel('Iteration','FontSize',14);
ylabel('Rise Time','FontSize',14);

subplot(2,2,4);
plot(ts_hist);
title('Settling Time','FontSize',18)
xlabel('Iteration','FontSize',14);
ylabel('time (s)','FontSize',14);


