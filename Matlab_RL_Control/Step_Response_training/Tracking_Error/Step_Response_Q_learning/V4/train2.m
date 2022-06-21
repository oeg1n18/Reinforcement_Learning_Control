% Training Parameters 
max_iter = 1000;

% Initialised PID parameters 
gains = [10,1,1];

% Transfer Function of Plant
P = tf([1,5], [1,2,3]);

del2 = 0.25;
reward2_hist = zeros(1, max_iter); 

Q_dimensions  = [length(5:del2:30), length(0.5:del2:20), length(0.5:del2:20)];
agent2 = QLearn(3,Q_dimensions,7, 1, max_iter);
env = Environment(P, gains);

for iter = 1:max_iter
    disp(agent2.epsilon);
    env.delta = del2;
    % get current state
    state = env.state;
    % choose action according to greedy policy
    action = agent2.action(env.state);
    % apply action to environment
    [reward, next_state] = env.step(action);
    % update Q-table with reward
    agent2.update_table(state, action, reward, next_state); 
    % Collect data
    reward2_hist(iter) = env.reward;
    % environment automatically transitions
end
response2 = env.y
save('Agent2_data', 'reward2_hist', 'del2', 'response2');
% Plotting
% Plotting

hold on 
plot(reward2_hist);
title('Reward','FontSize',18)
xlabel('Iteration','FontSize',14);

