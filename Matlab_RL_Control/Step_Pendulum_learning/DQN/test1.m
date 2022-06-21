max_iteration = 50;

% Create the Environment 
env = CartPole();


% Data Collection 
reward1_hist = zeros(1, max_iteration); 
Mp1_hist = zeros(1, max_iteration); 
norm1_hist = zeros(1, max_iteration); 
tr1_hist = zeros(1, max_iteration);


for iter = 1:max_iteration
    iter
    env.delta = del1;
    state = env.state;
    action = dqn1.exploit_action(env.state);
    [reward, next_state, failed] = env.take_action(action);
    reward1_hist(iter) = reward;

end

save('Agent1_data', 'reward1_hist', 'Mp1_hist', 'norm1_hist', 'tr1_hist', 'del1');

% Plotting
plot(reward1_hist);
title('Reward','FontSize',18)
xlabel('Iteration','FontSize',14);

