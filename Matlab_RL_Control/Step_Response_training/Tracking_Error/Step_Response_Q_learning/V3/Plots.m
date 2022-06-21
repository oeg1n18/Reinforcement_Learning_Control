
% Plotting
subplot(1,3,1);
plot(reward_hist(1, 1:max_iter));
title("Reward (delta=" + string(deltas(1)) + ")",'FontSize',14); 
xlabel('Iteration','FontSize',14);


subplot(1,3,2); 
plot(reward_hist(2, 1:max_iter));
title("Reward (delta=" + string(deltas(2)) + ")",'FontSize',14); 
xlabel('Iteration','FontSize',14);

subplot(1,3,3) 
plot(reward_hist(3, 1:max_iter));
title("Reward (delta=" + string(deltas(3)) + ")",'FontSize',14); 
xlabel('Iteration','FontSize',14);



