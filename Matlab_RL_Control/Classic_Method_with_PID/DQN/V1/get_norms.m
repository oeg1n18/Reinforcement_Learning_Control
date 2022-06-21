load('Training_variables')

env1 = envs(1);
env2 = envs(2);
env3 = envs(3);

norm1 = sum(abs(env1.theta_hist)*env1.tau);
norm2 = sum(abs(env2.theta_hist)*env2.tau);
norm3 = sum(abs(env3.theta_hist)*env3.tau);

disp('del = ' + string(env1.delta) + ' --- norm: ' + string(norm1));
disp('del = ' + string(env2.delta) + ' --- norm: ' + string(norm2));
disp('del = ' + string(env3.delta) + ' --- norm: ' + string(norm3));