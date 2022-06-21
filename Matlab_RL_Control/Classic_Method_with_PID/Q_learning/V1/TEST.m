

observations = zeros(length(deltas) + 1, env.episode_limit, 2); 


for d_i = 1:length(deltas)
    Q = Qs(d_i);
    env = CartPole();
    env.delta = deltas(d_i); 
    for step = 1:env.episode_limit
        env.delta = deltas(d_i);
        action = Q.exploit_action(env.state); 
        [reward, next_state,  failed, done] = env.take_action(action);
        
        % Record pendulum info
        observations(d_i, step, 1:2) = [env.theta, env.theta_dot];
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
    observations(length(deltas)+1, step, 1:2) = [env.theta, env.theta_dot];
end
    
    
    

% Plot the thetas 
t = 0:0.02:500*0.02-0.02;
subplot(1,2,1);
hold on 
for i = 1:length(deltas)+1
    plot(t, observations(i, 1:env.episode_limit, 1)*180/pi); 
end
title('Pendulum Angle', 'FontSize', 18);
ylabel('Angle (deg)', 'FontSize', 14);
xlabel('Times (s)', 'FontSize', 14);
legend('Delta = ' + string(deltas(1)), 'Delta = ' + string(deltas(2)),'Delta = ' + string(deltas(3)), 'Un-tuned');

subplot(1,2,2); 
hold on 
for i = 1:length(deltas)+1
    plot(t, observations(i, 1:env.episode_limit, 2)*180/pi); 
end
title("Angular Velocity", 'FontSize', 18); 
ylabel("Angle Velocity (deg/s)", 'FontSize',14);
xlabel("Time (s)", 'FontSize', 14);
legend('Delta = ' + string(deltas(1)), 'Delta = ' + string(deltas(2)),'Delta = ' + string(deltas(3)), 'Un-tuned');

        
    