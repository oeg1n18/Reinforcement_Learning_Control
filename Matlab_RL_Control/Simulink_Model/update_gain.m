function out_gains = update_gain(action, in_gains, d)
    %This is a discrete time PID controller
    Kp1 = in_gains(1); 
    Ki1 = in_gains(2); 
    Kd1 = in_gains(3); 

    delta = d;
    if action == 1
        Kp1 = in_gains(1) + delta; 
    elseif action == 2
        Kp1 = in_gains(1) - delta; 
    elseif action == 3 
        Ki1 = in_gains(2) + delta; 
    elseif action == 4
        Ki1 = in_gains(2) - delta; 
    elseif action == 5 
        Kd1 = in_gains(3) + delta; 
    elseif action == 6
        Kd1 = in_gains(3) - delta; 
    elseif action == 7
        Kp1 = in_gains(1); 
        Ki1 = in_gains(2); 
        Kd1 = in_gains(3);
    end
    
    % Check for any low values that would be unstable; 
    if Kp1 < 10
        Kp1 = 10; 
    elseif Ki1 < 1
        Ki1 = 1; 
    elseif Kd1 < 1
        Kd1 = 1; 
    end
    
    % check for any high values that could use too much force; 
    if Kp1 > 50
        Kp1 = 50; 
    elseif Ki1 > 20
        Ki1 = 20; 
    elseif Kd1 > 20
        Kd1 = 20; 
    end
    out_gains = [Kp1, Ki1, Kd1];
end
