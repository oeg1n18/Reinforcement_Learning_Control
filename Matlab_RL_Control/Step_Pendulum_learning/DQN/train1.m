
% Training Parameters 
max_iteration = 500; 
batch_size = 64; 
train_frequency = 8;


% Create the Environment 
env = CartPole();



% Create DDQN agent 
% 3 state vars, 7 possible actions, [24,10] Neural network layers
dqn1 = DQN(3, 7, [24, 10], 1, max_iteration);

% Data Collection 
reward1_hist = zeros(1, max_iteration); 
Mp1_hist = zeros(1, max_iteration); 
norm1_hist = zeros(1, max_iteration); 
tr1_hist = zeros(1, max_iteration);


i = 0;
del1 = 0.5;
for iter = 1:max_iteration
    env.delta = del1;
    disp(string(iter) + '    ' + string(dqn1.epsilon));
    state = env.state;
    action = dqn1.action(env.state);
    [reward, next_state, failed] = env.take_action(action);
    
    if state(1) ~= inf
        dqn1.store(state, action, reward, next_state);
    end
    
    if mod(iter, train_frequency) == 0
        dqn1.experience_replay(batch_size);
    end
        
    reward1_hist(iter) = reward; 
   
    clc;
    disp('Iteration -- ' + string(iter));
    
end
save('Training_variables', 'env', 'dqn1', 'Mp1_hist', 'norm1_hist', 'tr1_hist');
DQN_response = env.theta_hist;
save('DQN_response_data', 'DQN_response');


% Plotting

plot(reward1_hist);
title('Reward','FontSize',18)
xlabel('Iteration','FontSize',14);

plot(env.theta_hist*180/pi);



   

