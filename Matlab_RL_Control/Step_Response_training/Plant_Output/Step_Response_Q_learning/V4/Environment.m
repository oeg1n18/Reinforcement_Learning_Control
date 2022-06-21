classdef Environment < handle
    %ENV Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        CLTF;
        G;
        reward_weights = [1,1,1]
        gains;
        reward;
        state;
        delta = 0.25;
        lims; 
        Mp; 
        ts; 
        tr;
        
    end
    
    methods
        function obj = Environment(plant, gain_params, limits)
            %ENV Construct an instance of this class
            obj.G = plant;
            obj.CLTF = get_sys(plant, gain_params);
            obj.gains = gain_params;
            obj.lims = limits;
            obj.state = [1,1,1];
        end
        
        function [reward, next_state] = step(obj,a)
            %METHOD1 Summary of this method goes here
            obj.gains = update_gains(obj.gains, a, obj.delta);
            obj.CLTF = get_sys(obj.G, obj.gains);
            response = stepinfo(obj.CLTF);
            if response.Peak > 1
                state_vars = [(response.Peak-1)*100, response.SettlingTime, response.RiseTime];
            else 
                state_vars = [(1-response.Peak)*100, response.SettlingTime, response.RiseTime];
            end
            obj.Mp = state_vars(1); obj.ts = state_vars(2); obj.tr = state_vars(3);
            % convert to booleans
            for i = 1:3 
                if state_vars(i) > obj.lims(i)
                    obj.state(i) = 1;
                else 
                    obj.state(i) = 2;
                end
            end
            obj.reward = -(real(dot(obj.reward_weights, state_vars)^1.1));
            next_state = obj.state; 
            reward = obj.reward;
        end
    end
end

function out_gains = update_gains(in_gains, action, d)
%UPDATE_GAINS Summary of this function goes here
%   Detailed explanation goes here
    out_gains = zeros(1,3);
    Kp = in_gains(1); 
    Ki = in_gains(2); 
    Kd = in_gains(3); 

    delta = d;
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
    out_gains = [Kp, Ki, Kd];
end


function [sys] = get_sys(G,gains)
%GET_SYS Gets the Control system transfer function. 
    num = gains;
    den = [1,0];
    C = tf(num, den);
    OLTF = C*G;
    sys = OLTF/(1+OLTF);
end



