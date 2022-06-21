
% Training Parameters 
max_iteration = 1000;  
batch_size = 64; 
train_frequency = 8;



% Create the Environment 
G = tf([1,5], [1,2,3]);
env = Environment(G, [10,1,1]);



% Create DDQN agent 
% 3 state vars, 7 possible actions, [24,10] Neural network layers
dqn3 = DQN(3, 7, [24,10], 1, max_iteration-50);

% Data Collection 
reward3_hist = zeros(1, max_iteration); 


i = 0;
del3 = 0.5;
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
    
    disp(string(dqn3.epsilon) + " --  " + string(action));
        
    
    reward3_hist(iter) = reward; 

end
    




response3 = env.y;
save('Agent3_data', 'reward3_hist','del3', 'response3');

hold on 
plot(reward3_hist);
title('Reward','FontSize',18)
xlabel('Iteration','FontSize',14);


   




