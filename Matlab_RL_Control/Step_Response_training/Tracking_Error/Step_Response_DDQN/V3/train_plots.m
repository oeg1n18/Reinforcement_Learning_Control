% Plotting
subplot(1,3,1);
plot(reward1_hist);;
title("Reward (delta=" + string(deltas(1)) + ")",'FontSize',14); 
xlabel('Iteration','FontSize',14);

subplot(1,3,2); 
plot(reward2_hist);
title("Reward (delta=" + string(deltas(2)) + ")",'FontSize',14); 
xlabel('Iteration','FontSize',14);

subplot(1,3,3) 
plot(reward3_hist);
title("Reward (delta=" + string(deltas(3)) + ")",'FontSize',14); 
xlabel('Iteration','FontSize',14);