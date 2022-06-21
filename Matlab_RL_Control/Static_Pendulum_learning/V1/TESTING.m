env = CartPole();
t = 0.02:0.02:20;
env.reset(); 
env.Kp = 19.5;
env.Ki = 9; 
env.Kd = 4;
env.theta = -10*(pi/180);
env.noise_scalar = 0;
env.take_action(7); 
plot(t,env.theta_hist)
hold on 
env.reset();
env.theta = -10*(pi/180);
env.Kp = 15; 
env.Ki = 3; 
env.Kd = 3; 
env.take_action(7); 
plot(t,env.theta_hist) 
legend('Tuned Response', 'Untuned Response');