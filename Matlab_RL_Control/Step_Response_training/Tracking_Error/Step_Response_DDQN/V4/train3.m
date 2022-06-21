
% Training Parameters 
max_iteration = 1000;  
weights_copy_frequency = 32; 
batch_size = 64; 
train_frequency = 8;


% Create the Environment 
G = tf([1,5], [1,2,3]);
env = Environment(G, [10,1,1]);



% Create DDQN agent 
% 3 state vars, 7 possible actions, [24,10] Neural network layers
ddqn3 = DDQN(3, 7, [24,10], 1, max_iteration);

% Data Collection 
reward3_hist = zeros(1, max_iteration); 



del3 = 0.5;
for iter = 1:max_iteration
    iter
    env.delta = del3;
    state = env.state;
    action = ddqn3.action(env.state);
    [reward, next_state] = env.step(action);
    
    if state(1) ~= inf
        ddqn3.store(state, action, reward, next_state);
    end
    
    if mod(iter, train_frequency) == 0
        ddqn3.experience_replay(batch_size);
    end
    
    if mod(iter, weights_copy_frequency) == 0
        ddqn3.copy_weights_agent_to_target();
    end
    
    reward3_hist(iter) = reward; 
end
    


response3 = env.y;
save('Agent3_data', 'reward3_hist','del3', 'response3');
% Plotting
hold on 
plot(reward3_hist);
title('Reward','FontSize',18)
xlabel('Iteration','FontSize',14);

