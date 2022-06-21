load('Q_learning')
load('DQN_response_data')
load('DQN_response_data')
t = 0.02:0.02:500*0.02;

env = CartPole(); 
[reward, next_state,  failed] = env.take_action(7);

hold on 
title('Control Response', 'FontSize', 18); 
plot(env.time, env.theta_hist*180/pi);
plot(env.time, Q_learn_response*180/pi);
plot(env.time, DQN_response*180/pi); 
plot(env.time, DDQN_response*180/pi);
legend('Un-Tuned', 'Q-learning Tuned', 'DQN Tuned', 'DDQN Tuned', 'FontSize', 14);
xlabel('Time (s)','FontSize', 14); 
ylabel('Pendulum Angle (deg)', 'FontSize', 14);

disp('Q_learn_norm' + string(sum(abs(env.theta_hist*180/pi)*env.tau)));
disp('Q_learn_norm' + string(sum(abs(Q_learn_response*180/pi)*env.tau)));
disp('DQN_response' + string(sum(abs(DQN_response)*180/pi)*env.tau));
disp('DDQN_learn_norm' + string(sum(abs(DDQN_response*180/pi)*env.tau)));
