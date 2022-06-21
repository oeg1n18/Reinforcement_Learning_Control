
%Script Params 
max_iter = 200;


% Set Up environment
lims = [0.1,3.0,0.5];
env = Environment(P, gains, lims);
env.reward_weights = [1,1,1];



% For Plotting 
reward_hist = zeros(1, max_iter); 
Mp_hist = zeros(1, max_iter);
ts_hist = zeros(1, max_iter); 
tr_hist = zeros(1, max_iter);


for iter = 1:max_iter
    state = env.state;
    action = agent.exploit_action(env.state);
    [reward, next_state] = env.step(action);
    
    % Collect data
    reward_hist(iter) = reward;
    Mp_hist(iter) = env.Mp;
    ts_hist(iter) = env.ts;
    tr_hist(iter) = env.tr;
end



%% Plotting
subplot(2,2,1);
plot(reward_hist);
title('Reward','FontSize',18)
xlabel('Iteration','FontSize',14);

subplot(2,2,2); 
plot(Mp_hist);
title('Overshoot','FontSize',18)
ylabel('Mp (%)','FontSize',14);
xlabel('Iteration','FontSize',14);


subplot(2,2,3) 
plot(tr_hist);
title('Rise Time','FontSize',18); 
xlabel('Iteration','FontSize',14);
ylabel('Rise Time','FontSize',14);

subplot(2,2,4);
plot(ts_hist);
title('Settling Time','FontSize',18)
xlabel('Iteration','FontSize',14);
ylabel('time (s)','FontSize',14);
