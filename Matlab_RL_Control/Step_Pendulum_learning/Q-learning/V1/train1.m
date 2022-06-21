% Training Parameters 
max_iter = 500;

% Initialised PID parameters 
gains = [10,1,1];

% Transfer Function of Plant
P = tf([1,5], [1,2,3]);


reward1_hist = zeros(1, max_iter); 

Q_dimensions  = [length(5:0.5:30), length(0.5:0.5:20), length(0.5:0.5:20)];
env = CartPole();
% Create Agents 
agent1 = QLearn(3,Q_dimensions,7,1,max_training_episodes*5);



del1 = 0.5;
test_env = CartPole(); 
test_env.take_action(1);

for iter = 1:max_iter
    disp(string(iter) + '  ' + string(agent1.epsilon));
    env.delta = del1;
    % get current state
    state = env.state;
    % choose action according to greedy policy
    action = agent1.action(env.state);
    
    % apply action to environment
    [reward, next_state, failed] = env.take_action(action);
    % update Q-table with reward
    agent1.update_table(state, action, reward, next_state); 
    % Collect data
    reward1_hist(iter) = reward;
    % environment automatically transition 
    if mod(iter, 100) == 0
       save('Training_variables', 'agent1', 'env', 'reward1_hist');
    end
end

Q_learn_response = env.theta_hist
save('Q_learning', 'Q_learn_response');
% Plotting
hold on 
plot(reward1_hist);
title('Reward','FontSize',18)
xlabel('Iteration','FontSize',14);

