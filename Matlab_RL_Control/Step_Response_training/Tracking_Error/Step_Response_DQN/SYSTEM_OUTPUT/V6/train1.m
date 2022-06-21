
% Training Parameters 
max_iteration = 5000; 
weights_copy_frequency = 16; 
batch_size = 64; 
train_frequency = 8;


% Create the Environment 
G = tf([1,5], [1,2,3]);
env = Environment(G, [10,1,1]);



% Create DDQN agent 
% 3 state vars, 7 possible actions, [24,10] Neural network layers
dqn1 = DQN(3, 7, [24], 1, max_iteration-100);

% Data Collection 
reward1_hist = zeros(1, max_iteration); 
Mp1_hist = zeros(1, max_iteration); 
ts1_hist = zeros(1, max_iteration); 
tr1_hist = zeros(1, max_iteration);


i = 0;
del1 = 0.05;
for iter = 1:max_iteration
    
    env.delta = del1;
    state = env.state;
    action = dqn1.action(env.state);
    [reward, next_state] = env.step(action);
    
    if state(1) ~= inf
        dqn1.store(state, action, reward, next_state);
    end
    
    if mod(iter, train_frequency) == 0
        dqn1.experience_replay(batch_size);
    end
    
    disp(dqn1.epsilon);
        
    
    reward1_hist(iter) = reward; 
    Mp1_hist(iter) = state(1);
    ts1_hist(iter) = state(2);
    tr1_hist(iter) = state(3);
end
    



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

   

