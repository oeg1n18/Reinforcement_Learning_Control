% Training Parameters 
max_iter = 1000;

% Initialised PID parameters 
gains = [10,1,1];

% Transfer Function of Plant
P = tf([1,5], [1,2,3]);


reward1_hist = zeros(1, max_iter); 
Mp1_hist = zeros(1, max_iter);
tr1_hist = zeros(1, max_iter); 
norm1_hist = zeros(1, max_iter);


agent1 = QLearn(3,100,7, 1, max_iter);

env = CartPole();
del1 = 0.05;
test_env = CartPole(); 
test_env.take_action(1, 1.0);

for iter = 1:max_iter
    iter
    env.delta = del1;
    % get current state
    state = env.state;
    % choose action according to greedy policy
    action = agent1.action(env.state);
    
    % apply action to environment
    [reward, next_state, failed] = env.take_action(action, 1.0);
    % update Q-table with reward
    if isnan(next_state(1))
        next_state(1) = 100; 
    elseif isnan(next_state(2)) 
        next_state(2) = 100; 
    elseif isnan(next_state(3))
        next_state(3) = 100;
    elseif isnan(state(1))
        state(1) = 100; 
    elseif isnan(state(2))
        state(2) = 100; 
    elseif isnan(state(3))
        state(3) = 100;   
    end
    agent1.update_table(state, action, reward, next_state); 
    % Collect data
    reward1_hist(iter) = reward;
    Mp1_hist(iter) = env.peak;
    tr1_hist(iter) = env.tr;
    norm1_hist(iter) = env.norm;
    % environment automatically transition  
    save('Training_variables', 'agent1', 'env', 'reward1_hist', 'Mp1_hist', 'tr1_hist', 'norm1_hist');
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
ylabel('Rise Time (s)','FontSize',14);

subplot(2,2,4);
hold on 
plot(norm1_hist);
title('Settling Time','FontSize',18)
xlabel('Iteration','FontSize',14);
ylabel('time (s)','FontSize',14);
