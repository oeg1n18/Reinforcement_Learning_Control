load('Agent1_data');
load('Agent2_data');
load('Agent3_data');

env = Environment(P, gains);
env.step(7);

subplot(1,2,1);
hold on 
plot(reward1_hist);
plot(reward2_hist);
plot(reward3_hist);
title('Reward','FontSize',18)
xlabel('Iteration','FontSize',14);
legend('Delta=' + string(del1), 'Delta=' + string(del2), 'Delta=' + string(del3));

subplot(1,2,2); 
hold on 

plot(env.t,response1);
plot(env.t,response2);
plot(env.t,response3);
plot(env.t, env.y);
title('DQN Tuned Response','FontSize',18)
ylabel('output y(t)','FontSize',14);
xlabel('Time (s)','FontSize',14);
legend('Delta=' + string(del1), 'Delta=' + string(del2), 'Delta=' + string(del3), 'Un-Tuned');


