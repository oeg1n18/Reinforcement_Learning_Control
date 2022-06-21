% Training Parameters 
max_iter = 1000;

% Initialised PID parameters 
gains = [10,1,1];

% Transfer Function of Plant
P = tf([1,5], [1,2,3]);

del1 = 0.1;
reward1_hist = zeros(1, max_iter); 
Q_dimensions  = [length(5:del1:30), length(0.5:del1:20), length(0.5:del1:20)];
agent1 = QLearn(3,Q_dimensions,7, 1, max_iter);
env = Environment(P, gains);



for iter = 1:max_iter
    disp(agent1.epsilon);
    env.delta = del1;
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
   
    % environment automatically transitions
end
response1 = env.y;
save('Agent1_data', 'reward1_hist', 'del1', 'response1');
% Plotting
hold on 
plot(reward1_hist);
title('Reward','FontSize',18)
xlabel('Iteration','FontSize',14);

