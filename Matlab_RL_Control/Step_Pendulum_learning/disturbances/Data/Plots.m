
load('DDQN_disturbance_data');
load('DQN_disturbance_data');
load('Q_disturbance_data');

test = CartPole();
test.take_action(7,1.0);

hold on 
plot(test.time, test.theta_hist*180/pi);
plot(test.time, Q_learn_data*180/pi);
plot(test.time, DQN_data*180/pi);
plot(test.time, DDQN_data*180/pi); 
title('Tuned Response of Pendulum to Disturbance', 'FontSize', 18);
xlabel('Time (s)', 'FontSize', 14);
ylabel('Pendulum Angle (deg)', 'FontSize', 14);
legend('Un-tuned', 'Q-learning Tuned', 'DQN Tuned', 'DDQN Tuned', 'FontSize', 14);

