max_iteration = 200;

% Create the Environment 
G = tf([1,5], [1,2,3]);
env = Environment(G, [10,1,1]);
env.step(1)


% Data Collection 
reward1_hist = zeros(1, max_iteration); 
Mp1_hist = zeros(1, max_iteration); 
ts1_hist = zeros(1, max_iteration); 
tr1_hist = zeros(1, max_iteration);


for iter = 1:max_iteration
    env.delta = del1;
    state = env.state;
    action = ddqn1.exploit_action(env.state);
    [reward, next_state] = env.step(action);
    reward1_hist(iter) = reward; 
    Mp1_hist(iter) = state(1);
    ts1_hist(iter) = state(2);
    tr1_hist(iter) = state(3);
end

save('Agent1_data', 'reward1_hist', 'Mp1_hist', 'ts1_hist', 'tr1_hist', 'del1');
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
plot(ts1_hist);
title('Settling Time','FontSize',18)
xlabel('Iteration','FontSize',14);
ylabel('time (s)','FontSize',14);