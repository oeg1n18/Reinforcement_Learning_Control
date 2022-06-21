% Plotting
for i = 1:3
    hold on
    subplot(2,2,1);
    plot(reward_hist(i, 1:max_iteration));
    title('Reward','FontSize',18)
    xlabel('Iteration','FontSize',14);

    hold on 
    subplot(2,2,2); 
    plot(Mp_hist(i, 1:max_iteration));
    title('Overshoot','FontSize',18)
    ylabel('Mp (%)','FontSize',14);
    xlabel('Iteration','FontSize',14);

    hold on 
    subplot(2,2,3) 
    plot(tr_hist(i, 1:max_iteration));
    title('Rise Time','FontSize',18); 
    xlabel('Iteration','FontSize',14);
    ylabel('Rise Time','FontSize',14);
    
    hold on 
    subplot(2,2,4);
    plot(ts_hist(i, 1:max_iteration));
    title('Settling Time','FontSize',18)
    xlabel('Iteration','FontSize',14);
    ylabel('time (s)','FontSize',14);
end

subplot(2,2,1);
legend("Delta =" + string(deltas(1)),  "Delta = " + string(deltas(2)), "Delta = "+ string(deltas(3)));
subplot(2,2,2);
legend("Delta = " + string(deltas(1)),  "Delta = " + string(deltas(2)), "Delta = "+ string(deltas(3)));
subplot(2,2,3);
legend("Delta = " + string(deltas(1)),  "Delta = " + string(deltas(2)), "Delta = " + string(deltas(3)));
subplot(2,2,4);
legend("Delta = " + string(deltas(1)),  "Delta = " + string(deltas(2)), "Delta = "+ string(deltas(3)));