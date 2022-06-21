
subplot(2,3,1);
plot((1:step_count)*env.tau*env.episode_limit/60, reward_hist(1:step_count));
title('Reward','FontSize',18)
xlabel('Time (min)','FontSize',14);
subplot(2,3,2); 
plot((1:step_count)*env.tau*env.episode_limit/60, theta_hist(1:step_count)*180/pi)
xlabel('Time (min)','FontSize',14);
ylabel('Pendulum Angle', 'FontSize', 14); 
title('Pendulum Angle', 'FontSize', 14);
subplot(2,3,3);
plot((1:step_count)*env.tau*env.episode_limit/60, thetadot_hist(1:step_count)*180/pi);
xlabel('Time (min)','FontSize',14);
ylabel('Velocity (deg/second)', 'FontSize', 14); 
title('Pendulum Velocity', 'FontSize', 14);

subplot(2,3,4); 
plot((1:step_count)*env.tau*env.episode_limit/60,Kp_hist(1:step_count));
title('Kp','FontSize',18)
xlabel('Time (min)','FontSize',14); 
ylim([5,22])
subplot(2,3,5) 
plot((1:step_count)*env.tau*env.episode_limit/60, Ki_hist(1:step_count));
title('Ki','FontSize',18); 
xlabel('Time (min)','FontSize',14);
ylim([0,12]);
subplot(2,3,6);
plot((1:step_count)*env.tau*env.episode_limit/60, Kd_hist(1:step_count));
title('Kd','FontSize',18)
xlabel('Time (min)','FontSize',14);
ylim([0,12]);