function [next_state, reward, new_gains] = env(action, gains, W)
%ENV Summary of this function goes here
%   Detailed explanation goes here
next_state = ones(1,4);
[Kp, Ki, Kd] = update_gains(gains, action);


%% Get System
num = [1, 5]; 
den = [1,2,3];
G = tf(num, den);
% full closed loop transfer function 
sys = get_sys(G, [Kp, Ki, Kd]); 
response = stepinfo(sys);

next_state(1) = response.SettlingMin; 
next_state(2) = response.Overshoot;
next_state(3) = response.RiseTime;
next_state(4) = response.SettlingMax; 
reward = get_reward(W, response);
new_gains = [Kp, Ki, Kd];

end



function [Kp, Ki, Kd] = update_gains(in_gains, action)
%UPDATE_GAINS Summary of this function goes here
%   Detailed explanation goes here
    Kp = in_gains(1); 
    Ki = in_gains(2); 
    Kd = in_gains(3); 

    delta = 0.1;
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



function reward = get_reward(W,S)
%REWARD Calculates the reward from the environment.
%   Here the reward is the calculates as the weighted sum of the percentage SSE,
%   percentage overshoot and settling time.
    
    S_min = 1-S.SettlingMin;%abs(y(100)-1); % SSE as a percentage of input 
    Mp = S.Overshoot; 
    ts = S.SettlingTime;
    
    reward = -(W(1)*Mp + W(2)*S_min + W(3)*ts);
end



function [sys] = get_sys(G,gains)
%GET_SYS Gets the Control system transfer function. 
%   Get new control system with new parameters 

% controller
num = gains;
den = [1,0];
C = tf(num, den);
sys = feedback(G*C, 1);

end