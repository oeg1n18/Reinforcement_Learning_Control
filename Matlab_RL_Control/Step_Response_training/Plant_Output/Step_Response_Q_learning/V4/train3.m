% Training Parameters 
max_iter = 5000;

% Initialised PID parameters 
gains = [10,1,1];

% Transfer Function of Plant
P = tf([1,5], [1,2,3]);


reward1_hist = zeros(1, max_iter); 
Mp1_hist = zeros(1, max_iter);
ts1_hist = zeros(1, max_iter); 
tr1_hist = zeros(1, max_iter);

agent3 = QLearn(3,2,7, 1, max_iter);

lims = [2.5,7.0,5.0];
env = Environment(P, gains, lims);
del3 = 0.15;


for iter = 1:max_iter
    disp(agent3.epsilon);
    env.delta = del3;
    % get current state
    state = env.state;
    % choose action according to greedy policy
    action = agent3.action(env.state);
    % apply action to environment
    [reward, next_state] = env.step(action);
    % update Q-table with reward
    agent3.update_table(state, action, reward, next_state); 
    % Collect data
    reward1_hist(iter) = reward;
    Mp1_hist(iter) = env.Mp;
    ts1_hist(iter) = env.ts;
    tr1_hist(iter) = env.tr;
    % environment automatically transitions
end


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
plot(ts1_hist);
title('Settling Time','FontSize',18)
xlabel('Iteration','FontSize',14);
ylabel('time (s)','FontSize',14);
