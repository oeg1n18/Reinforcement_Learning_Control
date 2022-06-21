max_iteration = 50;

% Create the Environment 
env = CartPole();


% Data Collection 
reward1_hist = zeros(1, max_iteration); 
Mp1_hist = zeros(1, max_iteration); 
norm1_hist = zeros(1, max_iteration); 
tr1_hist = zeros(1, max_iteration);


for iter = 1:max_iteration
    env.delta = del1;
    state = env.state;
    action = ddqn1.exploit_action(env.state);
    [reward, next_state, failed] = env.take_action(action);
    reward1_hist(iter) = reward;
end

DDQN_theta = env.theta;
save('Agent1_data', 'DDQN_theta');

% Plotting

plot(reward1_hist);
title('Reward','FontSize',18)
xlabel('Iteration','FontSize',14);

disp('norm = ' + string(sum(abs(DDQN_theta)*env.tau*180/pi)));