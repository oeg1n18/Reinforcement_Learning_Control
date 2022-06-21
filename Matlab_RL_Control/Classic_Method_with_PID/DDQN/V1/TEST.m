

observations = zeros(length(deltas) + 1, env.episode_limit, 2); 


for d_i = 1:length(deltas)
    ddqn = ddqns(d_i);
    env = CartPole();
    env.delta = deltas(d_i); 
    for step = 1:env.episode_limit
        action = ddqn.exploit_action(env.state); 
        [reward, next_state,  failed, done] = env.take_action(action);
        
        % Record pendulum info
        observations(d_i, step, 1:2) = next_state;
        if failed 
            disp('Pendulum fell down for test with delta = ' + string(deltas(d_i))); 
            break; 
        end
    end
end

% For the un-trained case
env = CartPole();
for step = 1:env.episode_limit
    [reward, next_state,  failed, done] = env.take_action(7);
    observations(length(deltas)+1, step, 1:2) = next_state;
end
    
    
    

% Plot the thetas 
subplot(1,3,1);
hold on 
for i = 1:length(deltas)+1
    plot(observations(i, 1:env.episode_limit, 1)); 
end
title('Pendulum Angle', 'FontSize', 18);
legend('Delta = ' + string(deltas(1)), 'Delta = ' + string(deltas(2)),'Delta = ' + string(deltas(3)), 'Un-tuned');

subplot(1,3,2); 
hold on 
for i = 1:length(deltas)+1
    plot(observations(i, 1:env.episode_limit, 2)); 
end
title("Angular Velocity", 'FontSize', 18); 
legend('Delta = ' + string(deltas(1)), 'Delta = ' + string(deltas(2)),'Delta = ' + string(deltas(3)), 'Un-tuned');

        
    