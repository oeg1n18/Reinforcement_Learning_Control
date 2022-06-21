max_iter = 200;

env = Environment(P, gains, lims);
env.delta = del2;

% For Plotting 
reward2_hist = zeros(1, max_iter); 
Mp2_hist = zeros(1, max_iter);
ts2_hist = zeros(1, max_iter); 
tr2_hist = zeros(1, max_iter);

for iter = 1:max_iter
    state = env.state;
    action = agent2.exploit_action(env.state);
    [reward, next_state] = env.step(action);
    
    % Collect data
    reward2_hist(iter) = reward;
    Mp2_hist(iter) = env.Mp;
    ts2_hist(iter) = env.ts;
    tr2_hist(iter) = env.tr;
end

save('Agent2_data', 'reward2_hist', 'Mp2_hist', 'ts2_hist', 'tr2_hist', 'del2');

% Plotting
subplot(2,2,1);
hold on 
plot(reward2_hist);
title('Reward','FontSize',18)
xlabel('Iteration','FontSize',14);


subplot(2,2,2); 
hold on 
plot(Mp2_hist);
title('Overshoot','FontSize',18)
ylabel('Mp (%)','FontSize',14);
xlabel('Iteration','FontSize',14);


subplot(2,2,3) 
hold on
plot(tr2_hist);
title('Rise Time','FontSize',18); 
xlabel('Iteration','FontSize',14);
ylabel('Rise Time','FontSize',14);


subplot(2,2,4);
hold on
plot(ts2_hist);
title('Settling Time','FontSize',18)
xlabel('Iteration','FontSize',14);
ylabel('time (s)','FontSize',14);
