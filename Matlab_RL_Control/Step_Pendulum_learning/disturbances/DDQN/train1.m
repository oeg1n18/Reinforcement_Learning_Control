
% Training Parameters 
max_iteration = 2000; 
batch_size = 32; 
weight_cpy_freq = 16;
train_frequency = 8;


% Create the Environment 
env = CartPole();



% Create DDQN agent 
% 3 state vars, 7 possible actions, [24,10] Neural network layers
ddqn1 = DDQN(3, 7, [24], 1, max_iteration);

% Data Collection 
reward1_hist = zeros(1, max_iteration); 
Mp1_hist = zeros(1, max_iteration); 
norm1_hist = zeros(1, max_iteration); 
tr1_hist = zeros(1, max_iteration);


del1 = 0.05;
for iter = 1:max_iteration
    env.delta = del1;
    state = env.state;
    action = ddqn1.action(env.state);
    [reward, next_state, failed] = env.take_action(action, 1.0);
    
    ddqn1.store(state, action, reward, next_state);
    
    if mod(iter, train_frequency) == 0
        ddqn1.experience_replay(batch_size);
    end
    
    if mod(iter, weight_cpy_freq) == 0
        ddqn1.copy_weights_agent_to_target();
    end
        
    
    reward1_hist(iter) = reward; 
    Mp1_hist(iter) = state(1);
    tr1_hist(iter) = state(2);
    norm1_hist(iter) = state(3);
    
    

    disp('Iteration -- ' + string(iter) + ' Epsilon -- ' + string(ddqn1.epsilon));
    save('Training_variables', 'env', 'ddqn1', 'Mp1_hist', 'norm1_hist', 'tr1_hist');
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
plot(norm1_hist);
title('Norm1','FontSize',18)
xlabel('Iteration','FontSize',14);
ylabel('time (s)','FontSize',14);

   

