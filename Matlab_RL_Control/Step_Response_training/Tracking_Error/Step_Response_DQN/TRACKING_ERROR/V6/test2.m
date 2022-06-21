max_iteration = 200;

% Create the Environment 
G = tf([1,5], [1,2,3]);
env = Environment(G, [10,1,1]);
env.step(1)


% Data Collection 
reward2_hist = zeros(1, max_iteration); 
Mp2_hist = zeros(1, max_iteration); 
ts2_hist = zeros(1, max_iteration); 
tr2_hist = zeros(1, max_iteration);


for iter = 1:max_iteration
    env.delta = del2;
    state = env.state;
    action = ddqn2.exploit_action(env.state);
    [reward, next_state] = env.step(action);
    
    reward2_hist(iter) = reward;
    Mp2_hist(iter) = state(1);
    ts2_hist(iter) = state(2);
    tr2_hist(iter) = state(3);
    disp(string(action) + '  --- ' + string(reward));
end

save('Agent2_data', 'reward2_hist', 'Mp2_hist', 'ts2_hist', 'tr2_hist', 'del2');

% Plotting
subplot(2,2,1);
plot(reward2_hist);
title('Reward','FontSize',18)
xlabel('Iteration','FontSize',14);

subplot(2,2,2); 
plot(Mp2_hist);
title('Overshoot','FontSize',18)
ylabel('Mp (%)','FontSize',14);
xlabel('Iteration','FontSize',14);


subplot(2,2,3) 
plot(tr2_hist);
title('Rise Time','FontSize',18); 
xlabel('Iteration','FontSize',14);
ylabel('Rise Time','FontSize',14);

subplot(2,2,4);
plot(ts2_hist);
title('Settling Time','FontSize',18)
xlabel('Iteration','FontSize',14);
ylabel('time (s)','FontSize',14);