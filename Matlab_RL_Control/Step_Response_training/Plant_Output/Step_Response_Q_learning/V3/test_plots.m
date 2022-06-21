% Plotting

    
    subplot(2,2,1);
    hold on
    ylim([-250,0]);
    plot(reward1_hist);
    plot(reward2_hist);
    plot(reward3_hist);
    title('Reward','FontSize',18)
    xlabel('Iteration','FontSize',14);
    legend("Delta =" + string(deltas(1)),  "Delta = " + string(deltas(2)), "Delta = "+ string(deltas(3)));
    hold off

    
    subplot(2,2,2); 
    hold on 
    ylim([0,15]);
    plot(Mp1_hist);
    plot(Mp2_hist);
    plot(Mp3_hist);
    title('Overshoot','FontSize',18)
    ylabel('Mp (%)','FontSize',14);
    xlabel('Iteration','FontSize',14);
    hold off
    legend("Delta = " + string(deltas(1)),  "Delta = " + string(deltas(2)), "Delta = "+ string(deltas(3)));

    
    subplot(2,2,3) 
    hold on 
    ylim([0,15]);
    plot(tr1_hist);
    plot(tr1_hist);
    plot(tr1_hist);
    title('Rise Time','FontSize',18); 
    xlabel('Iteration','FontSize',14);
    ylabel('Rise Time','FontSize',14);
    hold off
    legend("Delta = " + string(deltas(1)),  "Delta = " + string(deltas(2)), "Delta = " + string(deltas(3)));
    
    
    subplot(2,2,4);
    hold on 
    ylim([0,180])
    plot(ts1_hist);
    plot(ts1_hist);
    plot(ts1_hist);
    title('Settling Time','FontSize',18)
    xlabel('Iteration','FontSize',14);
    ylabel('time (s)','FontSize',14);
    hold off
    legend("Delta = " + string(deltas(1)),  "Delta = " + string(deltas(2)), "Delta = "+ string(deltas(3)));

