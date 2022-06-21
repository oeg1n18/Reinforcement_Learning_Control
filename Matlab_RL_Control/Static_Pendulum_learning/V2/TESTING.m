load('Training Variables.mat')
env.episode_limit = 1000;
steps_lim = 10;
env.reset();
agent_theta_hist = env.theta_hist;


env.noise_scalar = 0.5;
for i = 1:steps_lim
    action = ddqn.exploit_action(env.state);
    env.take_action(action);
    agent_theta_hist = cat(1, agent_theta_hist, env.theta_hist);
end

env = CartPole();
env.noise_scalar = 0.5;
theta_hist = env.theta_hist;
for i = 1:steps_lim
    action = ddqn.exploit_action(env.state);
    env.take_action(7);
    theta_hist = cat(1, theta_hist, env.theta_hist);
end


t = linspace(0,env.episode_limit*steps_lim*0.02, length(agent_theta_hist) );
plot(t,agent_theta_hist)
hold on 
plot(t,theta_hist)
xlabel('Time (min)', 'FontSize', 14)
ylabel('Pendulum Angle (degrees)', 'FontSize', 14);
title('Tuned vs Un-tuned Pendulum Simulation', 'FontSize', 16);
legend('Tuned Response', 'Untuned Response');
hold off