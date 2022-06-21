
% Training Parameters 
max_iteration = 1000; 
batch_size = 32; 
weights_copy_frequency = 22; 
batch_size = 32; 
train_frequency = 8;


% Create the Environment 
G = tf([1,5], [1,2,3]);
env = Environment(G, [10,1,1]);



% Create DDQN agent 
% 3 state vars, 7 possible actions, [24,10] Neural network layers
ddqn = DQN(3, 7, [24], 100, max_iteration-100);

% Data Collection 
reward_hist = zeros(1, max_iteration); 
Mp_hist = zeros(1, max_iteration); 
ts_hist = zeros(1, max_iteration); 
tr_hist = zeros(1, max_iteration);


i = 0;
del = 0.1;
for iter = 1:max_iteration
    
    env.delta = del;
    state = env.state;
    action = ddqn.action(env.state);
    [reward, next_state] = env.step(action);
    
    if state(1) ~= inf
        ddqn.store(state, action, reward, next_state);
    end
    
    if mod(iter, train_frequency) == 0
        ddqn.experience_replay(batch_size);
    end
    
    if mod(iter, 100) == 0 
        i = i + 100;
        disp(i);
    end
        
    
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

   

