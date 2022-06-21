
function [out_gains] = update_gains(in_gains, action, d)
%UPDATE_GAINS Summary of this function goes here
% updates alters PID gains according to 7 different actions
    out_gains = zeros(1,3);
    Kp = in_gains(1); 
    Ki = in_gains(2); 
    Kd = in_gains(3); 

    delta = d;
    if action == 1
        Kp = in_gains(1) + delta*in_gains(1); 
    elseif action == 2
        Kp = in_gains(1) - delta*in_gains(1); 
    elseif action == 3 
        Ki = in_gains(2) + delta*in_gains(2); 
    elseif action == 4
        Ki = in_gains(2) - delta*in_gains(2); 
    elseif action == 5 
        Kd = in_gains(3) + delta*in_gains(3); 
    elseif action == 6
        Kd = in_gains(3) - delta*in_gains(3); 
    elseif action == 7
        Kp = in_gains(1); 
        Ki = in_gains(2); 
        Kd = in_gains(3);
    end
    
    
    % Check for any negative values; 
    if Kp < 0.0
        Kp = 0.0; 
    end
    if Ki < 0.0
        Ki = 0.0;
    end
    if Kd < 0.0
        Kd = 0.0; 
    end
    
    out_gains = [Kp, Ki, Kd];
        
end


