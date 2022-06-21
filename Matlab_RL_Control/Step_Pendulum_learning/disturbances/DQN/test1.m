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
    [reward, next_state, failed] = env.take_action(action, 1.0);
    reward1_hist(iter) = reward;
    Mp1_hist(iter) = state(1);
    norm1_hist(iter) = state(2);
    tr1_hist(iter) = state(3);
end

save('Agent1_data', 'reward1_hist', 'Mp1_hist', 'norm1_hist', 'tr1_hist', 'del1');

% Plotting
subplot(2,2,1);
plot(reward1_hist);
title('Reward','FontSize',18)
xlabel('Iteration','FontSize',14);

subplot(2,2,2); 
plot(Mp1_hist);
title('Overshoot','FontSize',18)
ylabel('Mp (%)','FontSize',14);
xlabel('Iteration','FontSize',14);


subplot(2,2,3) 
plot(tr1_hist);
title('Rise Time','FontSize',18); 
xlabel('Iteration','FontSize',14);
ylabel('Rise Time','FontSize',14);

subplot(2,2,4);
plot(norm1_hist);
title('Norm1','FontSize',18)
xlabel('Iteration','FontSize',14);
ylabel('time (s)','FontSize',14);