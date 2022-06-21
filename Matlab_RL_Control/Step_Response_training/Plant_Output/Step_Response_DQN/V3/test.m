max_iteration = 200;

% Create the Environment 
G = tf([1,5], [1,2,3]);
env = Environment(G, [10,1,1]);


% Data Collection 
reward_hist = zeros(1, max_iteration); 
Mp_hist = zeros(1, max_iteration); 
ts_hist = zeros(1, max_iteration); 
tr_hist = zeros(1, max_iteration);


for iter = 1:max_iteration
    env.delta = 0.1;
    state = env.state;
    action = ddqn.exploit_action(env.state);
    [reward, next_state] = env.step(action);
    reward_hist(iter) = reward;
    Mp_hist(iter) = state(1);
    ts_hist(iter) = state(2);
    tr_hist(iter) = state(3);
end

% Plotting
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