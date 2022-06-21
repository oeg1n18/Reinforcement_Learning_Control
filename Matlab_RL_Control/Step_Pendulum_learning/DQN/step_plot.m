

test_env = CartPole(); 
test_env.take_action(7); 

hold on 
title("Step Response", 'FontSize', 18);
plot(test_env.time, test_env.theta_hist*180/pi); 
plot(env.time, env.theta_hist* 180/pi); 
legend('Un-tuned', 'DQN Tuned', 'FontSize', 14)
xlabel('Time (s)', 'FontSize', 14)
ylabel('Pendulum Angle (deg)','FontSize', 14);
