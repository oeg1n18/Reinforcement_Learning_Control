
% Training Parameters 
max_iteration = 1000;  
batch_size = 64; 
train_frequency = 8;


% Create the Environment 
G = tf([1,5], [1,2,3]);
env = Environment(G, [10,1,1]);



% Create DDQN agent 
% 3 state vars, 7 possible actions, [24,10] Neural network layers
dqn1 = DQN(3, 7, [24,10], 1, max_iteration);

% Data Collection 
reward1_hist = zeros(1, max_iteration); 



i = 0;
del1 = 0.1;
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
end
    
response1 = env.y;
save('Agent1_data', 'reward1_hist', 'del1', 'response1');

hold on 
plot(reward1_hist);
title('Reward','FontSize',18)
xlabel('Iteration','FontSize',14);

   

