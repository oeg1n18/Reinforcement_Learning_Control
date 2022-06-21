
clc;
globals;
load('DQN_Training_Variables');
load('DDQN_Training_Variables');
load('Q_Training_Variables');

env = Environment("Continuous", 0.5);
env.step(7);

hold on 
plot(env.time, env.angle.values*180/pi);
plot(Q_time, Q_angle*180/pi);
plot(dqn_time, dqn_angle*180/pi);
plot(ddqn_time, ddqn_angle*180/pi);
legend('Un-tuned', 'Q-Learning Tuned', 'DQN Tuned', 'DDQN Tuned');
xlabel('Time (s)', 'FontSize', 14);
ylabel('Angle (deg)', 'FontSize', 14);
hold off


hold on 
title('Training Reward', 'FontSize', 18);
xlabel('Iteration', 'FontSize', 14);
plot(Q_reward); 
plot(dqn_reward);
plot(ddqn_reward);
legend('Q-Learn', 'DQN', 'DDQN');
hold off


disp("====== Norms =====");
disp("Un-Tuned: " + string(sum(abs(env.angle.values))));
disp("Q Tuned: " + string(sum(abs(Q_angle))));
disp("DQN Tuned: " + string(sum(abs(dqn_angle))));
disp("DDQN Tuned: " + string(sum(abs(ddqn_angle))));

