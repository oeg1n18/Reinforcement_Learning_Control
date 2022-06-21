classdef Environment < handle
    %ENV Summary of this class goes here
    %   Detailed explanation goes here
    properties
        CLTF;
        G;
        gains;
        reward;
        state;
        delta = 0.5;
        norm;
        t = linspace(0,40,400);
        u = ones(size(linspace(0,10,400)))
        
        y;
    end
    
    methods
        function obj = Environment(plant, gain_params)
            %ENV Construct an instance of this class
            obj.G = plant;
            obj.CLTF = get_sys(plant, gain_params);
            obj.gains = gain_params;
            obj.state = [1,1,1];
        end
        
        function [reward, next_state] = step(obj,a)
            %METHOD1 Summary of this method goes here
            obj.gains = update_gains(obj.gains, a, obj.delta);
            obj.CLTF = get_sys(obj.G, obj.gains);
            obj.y = reshape(lsim(obj.CLTF, obj.u, obj.t), [1, 400]);
            error = obj.y - obj.u;
            
            obj.norm = sum(abs(error)*(obj.t(2)-obj.t(1)));
            
            obj.state = [obj.gains(1), obj.gains(2), obj.gains(3)];
            obj.reward = -(obj.norm);
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
    if Kp < 5
       Kp = 5; 
    elseif Ki < 0.5
        Ki = 0.5; 
    elseif Kd < 0.5
        Kd = 0.5; 
    end
    
    if Kp > 30
        Kp = 30; 
    elseif Kd > 20
        Kd = 20; 
    elseif Ki > 20 
        Ki = 20;
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



