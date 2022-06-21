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
ddqn2 = DDQN(3, 7, [24,10], 1, max_iteration);

% Data Collection 
reward2_hist = zeros(1, max_iteration); 


del2 = 0.25;
for iter = 1:max_iteration
    disp(ddqn2.epsilon);
    env.delta = del2;
    state = env.state;
    action = ddqn2.action(env.state);
    [reward, next_state] = env.step(action);
    
    if state(1) ~= inf
        ddqn2.store(state, action, reward, next_state);
    end
    
    if mod(iter, train_frequency) == 0
        ddqn2.experience_replay(batch_size);
    end
    
    if mod(iter, weights_copy_frequency) == 0
        ddqn2.copy_weights_agent_to_target();
    end
    
    reward2_hist(iter) = reward; 
end
    


response2 = env.y;
save('Agent2_data', 'reward2_hist', 'del2', 'response2');
% Plotting

hold on 
plot(reward2_hist);
title('Reward','FontSize',18)
xlabel('Iteration','FontSize',14);

