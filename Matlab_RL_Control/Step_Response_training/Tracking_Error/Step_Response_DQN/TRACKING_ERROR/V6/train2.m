
% Training Parameters 
max_iteration = 1000;  
batch_size = 64; 
train_frequency = 8;



% Create the Environment 
G = tf([1,5], [1,2,3]);
env = Environment(G, [10,1,1]);


% Create DDQN agent 
% 3 state vars, 7 possible actions, [24,10] Neural network layers
dqn2 = DQN(3, 7, [24,10], 1, max_iteration);

% Data Collection 
reward2_hist = zeros(1, max_iteration); 


i = 0;
del2 = 0.25;
for iter = 1:max_iteration
    
    env.delta = del2;
    state = env.state;
    action = dqn2.action(env.state);
    [reward, next_state] = env.step(action);
    
    if state(1) ~= inf
        dqn2.store(state, action, reward, next_state);
    end
    
    if mod(iter, train_frequency) == 0
        dqn2.experience_replay(batch_size);
    end
    
    disp(dqn2.epsilon);
        
    
    reward2_hist(iter) = reward; 
end
    


response2 = env.y;
save('Agent2_data', 'reward2_hist',  'del2', 'response2');

% Plotting
hold on 
plot(reward2_hist);
title('Reward','FontSize',18)
xlabel('Iteration','FontSize',14);

   




