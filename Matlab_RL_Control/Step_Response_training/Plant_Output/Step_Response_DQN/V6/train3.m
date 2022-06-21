% Training Parameters 
max_iteration = 5000; 
weights_copy_frequency = 16; 
batch_size = 32; 
train_frequency = 8;


% Create the Environment 
G = tf([1,5], [1,2,3]);
env = Environment(G, [10,1,1]);



% Create DDQN agent 
% 3 state vars, 7 possible actions, [24,10] Neural network layers
dqn3 = DQN(3, 7, [24], 1, max_iteration);

% Data Collection 
reward3_hist = zeros(1, max_iteration); 
Mp3_hist = zeros(1, max_iteration); 
ts3_hist = zeros(1, max_iteration); 
tr3_hist = zeros(1, max_iteration);


i = 0;
del3 = 0.15;
for iter = 1:max_iteration
    
    env.delta = del3;
    state = env.state;
    action = dqn3.action(env.state);
    [reward, next_state] = env.step(action);
    if state(1) ~= inf
        dqn3.store(state, action, reward, next_state);
    end
    
    if mod(iter, train_frequency) == 0
        dqn3.experience_replay(batch_size);
    end
    
    disp([string(dqn3.epsilon) + " --  " + string(action)]);
        
    
    reward3_hist(iter) = reward; 
    Mp3_hist(iter) = state(1);
    ts3_hist(iter) = state(2);
    tr3_hist(iter) = state(3);
end
    



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

   

