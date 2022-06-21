function [Kp, Ki, Kd] = update_gains(in_gains, action)
%UPDATE_GAINS Summary of this function goes here
%   Detailed explanation goes here
    Kp = in_gains(1); 
    Ki = in_gains(2); 
    Kd = in_gains(3); 

    delta = 0.3;
    if action == 1
        Kp = in_gains(1) + delta; 
    elseif action == 2
        Kp = in_gains(1) - delta; 
    elseif action == 3 
        Ki = in_gains(2) + delta; 
    elseif action == 4
        Ki = in_gains(2) - delta; 
    elseif action == 5 
        Kd = in_gains(3) + delta; 
    elseif action == 6
        Kd = in_gains(3) - delta; 
    elseif action == 7
        Kp = in_gains(1); 
        Ki = in_gains(2); 
        Kd = in_gains(3);
    end
    
    
    % Check for any negative values; 
    if Kp < 0
       Kp = 0; 
    elseif Ki < 0
        Ki = 0; 
    elseif Kd < 0
        Kd = 0; 
    end
        
end