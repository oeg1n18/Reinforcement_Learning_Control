load('Test_variables')
env = CartPole(); 
for i = 1:env.episode_limit
    env.take_action(7);
end

env1 = envs(1);
env2 = envs(2);
env3 = envs(3);

norm = sum(abs(env.theta_hist*180/pi)*env.tau);
norm1 = sum(abs(env1.theta_hist*180/pi)*env1.tau);
norm2 = sum(abs(env2.theta_hist*180/pi)*env2.tau);
norm3 = sum(abs(env3.theta_hist*180/pi)*env3.tau);

disp('un-tuned ' + string(env1.delta) + ' --- norm: ' + string(norm));
disp('del = ' + string(env1.delta) + ' --- norm: ' + string(norm1));
disp('del = ' + string(env2.delta) + ' --- norm: ' + string(norm2));
disp('del = ' + string(env3.delta) + ' --- norm: ' + string(norm3));

hold on 
plot(env1.theta_hist);
plot(env2.theta_hist);
plot(env3.theta_hist);