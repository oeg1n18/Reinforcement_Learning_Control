max_iter = 50;

env = CartPole();
env.delta = del1;

% For Plotting 
reward1_hist = zeros(1, max_iter); 


for iter = 1:max_iter
    disp(iter)
    state = env.state;
    action = agent1.exploit_action(env.state);
    [reward, next_state, failed] = env.take_action(action);
    
    % Collect data
    reward1_hist(iter) = reward;
end
Q_theta = env.theta_hist;
save('Agent1_data',  'Q_theta');

% Plotting
hold on 
plot(reward1_hist);
title('Reward','FontSize',18)
xlabel('Iteration','FontSize',14);
hold off 

pl

disp('norm for del = 0.5' + string(sum(abs(env.theta_hist))));


