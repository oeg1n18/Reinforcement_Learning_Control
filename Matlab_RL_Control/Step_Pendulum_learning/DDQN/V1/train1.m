
% Training Parameters 
max_iteration = 1000; 
batch_size = 64; 
weight_cpy_freq = 32;
train_frequency = 8;

% Create the Environment 
env = CartPole();

% Create DDQN agent 
% 3 state vars, 7 possible actions, [24,10] Neural network layers
ddqn1 = DDQN(3, 7, [24,10], 1, max_iteration);

% Data Collection 
reward1_hist = zeros(1, max_iteration); 
Mp1_hist = zeros(1, max_iteration); 
norm1_hist = zeros(1, max_iteration); 
tr1_hist = zeros(1, max_iteration);

i = 0;
del1 = 0.5;
for iter = 1:max_iteration
    disp(string(iter) + '    ' + string(ddqn1.epsilon));
    env.delta = del1;
    state = env.state;
    action = ddqn1.action(env.state);
    [reward, next_state, failed] = env.take_action(action);
  
    if state(1) ~= inf
        ddqn1.store(state, action, reward, next_state);
    end
    
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
    
    
    
    if mod(iter, 20) == 0
        clc;
        disp('Iteration -- ' + string(iter) + ' Epsilon -- ' + string(ddqn1.epsilon) + ' Norm:  ' + string(env.norm));
        save('Training_variables', 'env', 'ddqn1', 'Mp1_hist', 'norm1_hist', 'tr1_hist');
    end
end
    

DDQN_response = env.theta_hist;
save('DQN_response_data', 'DDQN_response');

% Plotting
plot(reward1_hist);
title('Reward','FontSize',18)
xlabel('Iteration','FontSize',14);

