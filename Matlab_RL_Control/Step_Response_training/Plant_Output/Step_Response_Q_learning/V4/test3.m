max_iter = 200;

env = Environment(P, gains, lims);
env.delta = del3;

% For Plotting 
reward3_hist = zeros(1, max_iter); 
Mp3_hist = zeros(1, max_iter);
ts3_hist = zeros(1, max_iter); 
tr3_hist = zeros(1, max_iter);

for iter = 1:max_iter
    state = env.state;
    action = agent3.exploit_action(env.state);
    [reward, next_state] = env.step(action);
    
    % Collect data
    reward3_hist(iter) = reward;
    Mp3_hist(iter) = env.Mp;
    ts3_hist(iter) = env.ts;
    tr3_hist(iter) = env.tr;
end

save('Agent3_data', 'reward3_hist', 'Mp3_hist', 'ts3_hist', 'tr3_hist', 'del3');

% Plotting
subplot(2,2,1);
hold on 
plot(reward3_hist);
title('Reward','FontSize',18)
xlabel('Iteration','FontSize',14);


subplot(2,2,2); 
hold on 
plot(Mp3_hist);
title('Overshoot','FontSize',18)
ylabel('Mp (%)','FontSize',14);
xlabel('Iteration','FontSize',14);


subplot(2,2,3) 
hold on
plot(tr3_hist);
title('Rise Time','FontSize',18); 
xlabel('Iteration','FontSize',14);
ylabel('Rise Time','FontSize',14);


subplot(2,2,4);
hold on
plot(ts3_hist);
title('Settling Time','FontSize',18)
xlabel('Iteration','FontSize',14);
ylabel('time (s)','FontSize',14);