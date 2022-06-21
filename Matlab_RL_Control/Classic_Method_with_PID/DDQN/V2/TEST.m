

observations = zeros(length(deltas) + 1, env.episode_limit, 2); 

envs = [CartPole(), CartPole(), CartPole()];
for d_i = 1:length(deltas)
    ddqn = ddqns(d_i);
    env = envs(d_i);
    env.delta = deltas(d_i); 
    for step = 1:env.episode_limit
        action = ddqn.exploit_action(env.state); 
        [reward, next_state,  failed, done] = env.take_action(action);
        
        % Record pendulum info
        observations(d_i, step, 1:2) = [env.theta, env.theta_dot];
        if failed 
            disp('Pendulum fell down for test with delta = ' + string(deltas(d_i))); 
            break; 
        end
    end
    save('Test_variables', 'envs');
end

% For the un-trained case
env = CartPole();
for step = 1:env.episode_limit
    [reward, next_state,  failed, done] = env.take_action(7);
    observations(length(deltas)+1, step, 1:2) = [env.theta, env.theta_dot];
end
    
    
norms = zeros(1,4);
for i = 1:length(deltas)+1
    norms(i) = sum(abs(observations(i, 1:env.episode_limit, 1)*(180/pi)*env.tau));
end

% Plot the thetas 
t = 0:0.02:500*0.02-0.02;

hold on 
for i = 1:length(deltas)+1
    plot(t, observations(i, 1:env.episode_limit, 1)*180/pi); 
end
title('Pendulum Angle', 'FontSize', 18);
ylabel('Angle (deg)', 'FontSize', 14);
xlabel('Times (s)', 'FontSize', 14);
legend('Delta = ' + string(deltas(1)), 'Delta = ' + string(deltas(2)),'Delta = ' + string(deltas(3)), 'Un-tuned');


disp('Untuned_norm: ' +string(norms(4)));
disp('del = 0.1: ' +string(norms(1)));
disp('del = 0.25: ' +string(norms(2)));
disp('del = 0.5: ' +string(norms(3)));
    
        
    