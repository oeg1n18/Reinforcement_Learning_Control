% Training Parameters 
max_iteration = 1000; 
batch_size = 64; 
train_frequency = 16;


% Create the Environment 
G = tf([1,5], [1,2,3]);
env = Environment(G, [10,1,1]);


% Create DDQN agent 
% 3 state vars, 7 possible actions, [24,10] Neural network layers
ddqn2 = DQN(3, 7, [24], 100, max_iteration);

% Data Collection 
reward2_hist = zeros(1, max_iteration); 
Mp2_hist = zeros(1, max_iteration); 
ts2_hist = zeros(1, max_iteration); 
tr2_hist = zeros(1, max_iteration);


i = 0;
del2 = 0.1;
for iter = 1:max_iteration
    
    env.delta = del2;
    state = env.state;
    action = ddqn2.action(env.state);
    [reward, next_state] = env.step(action);
    
    if state(1) ~= inf
        ddqn2.store(state, action, reward, next_state);
    end
    
    if mod(iter, train_frequency) == 0
        ddqn2.experience_replay(batch_size);
    end
    
    disp(ddqn2.epsilon);
        
    
    reward2_hist(iter) = reward; 
    Mp2_hist(iter) = state(1);
    ts2_hist(iter) = state(2);
    tr2_hist(iter) = state(3);
end
    



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


