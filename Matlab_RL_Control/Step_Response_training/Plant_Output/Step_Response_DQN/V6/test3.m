max_iteration = 200;

% Create the Environment 
G = tf([1,5], [1,2,3]);
env = Environment(G, [10,1,1]);


% Data Collection 
reward3_hist = zeros(1, max_iteration); 
Mp3_hist = zeros(1, max_iteration); 
ts3_hist = zeros(1, max_iteration); 
tr3_hist = zeros(1, max_iteration);


for iter = 1:max_iteration
    env.delta = del3;
    state = env.state;
    action = dqn3.exploit_action(env.state);
    [reward, next_state] = env.step(action);
    reward3_hist(iter) = reward;
    Mp3_hist(iter) = state(1);
    ts3_hist(iter) = state(2);
    tr3_hist(iter) = state(3);
    disp(action);
end

save('Agent3_data', 'reward3_hist', 'Mp3_hist', 'ts3_hist', 'tr3_hist', 'del3');

% Plotting
subplot(2,2,1);
plot(reward3_hist);
title('Reward','FontSize',18)
xlabel('Iteration','FontSize',14);

subplot(2,2,2); 
plot(Mp3_hist);
title('Overshoot','FontSize',18)
ylabel('Mp (%)','FontSize',14);
xlabel('Iteration','FontSize',14);


subplot(2,2,3) 
plot(tr3_hist);
title('Rise Time','FontSize',18); 
xlabel('Iteration','FontSize',14);
ylabel('Rise Time','FontSize',14);

subplot(2,2,4);
plot(ts3_hist);
title('Settling Time','FontSize',18)
xlabel('Iteration','FontSize',14);
ylabel('time (s)','FontSize',14);