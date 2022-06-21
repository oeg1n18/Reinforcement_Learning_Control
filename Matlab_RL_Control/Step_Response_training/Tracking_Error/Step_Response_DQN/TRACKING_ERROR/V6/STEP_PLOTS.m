load('Agent1_data');
load('Agent2_data');
load('Agent3_data');

P = tf([1,5], [1,2,3]);
gains = [10,1,1];
env = Environment(P, gains);
env.step(7);

hold on 
title('Step Resoponse','FontSize',18)
xlabel('Time (s)','FontSize',14);

plot(env.t, env.y);
plot(env.t, response1);
plot(env.t, response2);
plot(env.t, response3);
ylabel('System Output', 'FontSize', 14);
legend('Un-tuned', 'Delta=' + string(del1), 'Delta=' + string(del2), 'Delta=' + string(del3));

disp('Un-tuned norm:' + string(sum(abs(env.y-1) * (env.t(2) - env.t(1)))));
disp('del1 norm:' + string(sum(abs(response1-1) * (env.t(2) - env.t(1)))));
disp('del2 norm:' + string(sum(abs(response2-1) * (env.t(2) - env.t(1)))));
disp('del3 norm:' + string(sum(abs(response3-1) * (env.t(2) - env.t(1)))));