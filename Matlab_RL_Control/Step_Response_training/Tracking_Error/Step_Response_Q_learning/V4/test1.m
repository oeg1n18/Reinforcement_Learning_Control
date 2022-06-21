max_iter = 200;

env = Environment(P, gains);
env.delta = del1;

% For Plotting 
reward1_hist = zeros(1, max_iter); 
Mp1_hist = zeros(1, max_iter);
ts1_hist = zeros(1, max_iter); 
tr1_hist = zeros(1, max_iter);

for iter = 1:max_iter
    state = env.state;
    action = agent1.exploit_action(env.state);
    action
    [reward, next_state] = env.step(action);
    
    % Collect data
    reward1_hist(iter) = reward;
    Mp1_hist(iter) = env.error_peak;
    ts1_hist(iter) = env.crossing_time;
    tr1_hist(iter) = env.norm;
end

response1 = env.y;
save('Agent1_data', 'reward1_hist', 'Mp1_hist', 'ts1_hist', 'tr1_hist', 'del1', 'response1');

% Plotting
subplot(2,2,1);
hold on 
plot(reward1_hist);
title('Reward','FontSize',18)
xlabel('Iteration','FontSize',14);


subplot(2,2,2); 
hold on 
plot(Mp1_hist);
title('Peak Error','FontSize',18)
ylabel('Mp (%)','FontSize',14);
xlabel('Iteration','FontSize',14);


subplot(2,2,3) 
hold on
plot(ts1_hist);
title('Error Crossing','FontSize',18); 
xlabel('Iteration','FontSize',14);
ylabel('Rise Time','FontSize',14);


subplot(2,2,4);
hold on
plot(tr1_hist);
title('Error Norm','FontSize',18)
xlabel('Iteration','FontSize',14);
ylabel('time (s)','FontSize',14);
