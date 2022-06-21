load('Training Variables')

max_steps = 15; 
env.noise_scalar = 0.0; 

for i = 1:15 
    action = ddqn.exploit_action(env.state); 
    env.take_action(action); 
end
Kp = env.Kp
Ki = env.Ki
Kd = env.Kd

env = CartPole(); 
env.noise_scalar = 0.0; 
env.theta = -8*pi/180;
env.Kp = Kp; 
env.Ki = Ki; 
env.Kd = Kd; 
env.take_action(7); 
plot(env.theta_hist); 



env = CartPole();
env.noise_scalar = 0.0; 
env.theta = -8*pi/180;
env.take_action(7); 
hold on 
plot(env.theta_hist) 
legend('Tuned parameters', 'Un-tuned');
    