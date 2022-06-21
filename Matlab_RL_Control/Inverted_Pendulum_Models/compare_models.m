state_space_vars;

limit = 5;
tau = 0.02;

x0 = [0; 0; -3*pi/180; 0];

sys_ss_cont = ss(A, B, C, D, 'TimeUnit', 'nanoseconds');
sys_ss_disc = ss(A, B, C, D, tau, 'TimeUnit', 'nanoseconds');

t1 = 0:tau:limit;
u = ones(length(t1), 1)*2;

y_cont = lsim(sys_ss_cont, u, t1, x0);

F = 2;


[t, y] = ode45(@(t, theta) theta_dotdot(t, theta, F, M, m, l, I, g), [0, limit], [-3*pi/180; 0]);



hold on 
plot(t1, y_cont*180/pi);
ylim([0,360])
plot(t, y(:,1)*180/pi);
ylabel('Angle (deg)', 'FontSize', 14);
xlabel('Time (S)', 'FontSize', 14);
title('Model Comparison', 'FontSize', 18);
legend("Linear", "Non-Linear", 'FontSize', 14);


