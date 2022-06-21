max_iter = 50;

env = CartPole();
env.delta = del1;

% For Plotting 
reward1_hist = zeros(1, max_iter); 
Mp1_hist = zeros(1, max_iter);
norm1_hist = zeros(1, max_iter); 
tr1_hist = zeros(1, max_iter);

for iter = 1:max_iter
    disp(iter)
    state = env.state;
    action = agent1.exploit_action(env.state);
    [reward, next_state, failed] = env.take_action(action, 1.0);
    
    % Collect data
    reward1_hist(iter) = reward;
    Mp1_hist(iter) = env.peak;
    norm1_hist(iter) = env.norm;
    tr1_hist(iter) = env.tr;
end

save('Agent1_data', 'reward1_hist', 'Mp1_hist', 'norm1_hist', 'tr1_hist', 'del1');

% Plotting
subplot(2,2,1);
hold on 
plot(reward1_hist);
title('Reward','FontSize',18)
xlabel('Iteration','FontSize',14);


subplot(2,2,2); 
hold on 
plot(Mp1_hist);
title('Overshoot','FontSize',18)
ylabel('Mp (%)','FontSize',14);
xlabel('Iteration','FontSize',14);


subplot(2,2,3) 
hold on
plot(tr1_hist);
title('Rise Time','FontSize',18); 
xlabel('Iteration','FontSize',14);
ylabel('Rise Time','FontSize',14);


subplot(2,2,4);
hold on
plot(norm1_hist);
title('Settling Time','FontSize',18)
xlabel('Iteration','FontSize',14);
ylabel('time (s)','FontSize',14);
