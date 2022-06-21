classdef Environment < handle
    %ENV Summary of this class goes here
    %   Converts a system step response to Plant tf G 
    %   with PID controller to an environment suitable for RL
    properties
        state = rand(1,3); % state of the env
        plant; % Plant and controller OLTF
        CLTF; % OLTF in feedback loop
        gains; % PID gains
        delta = 0.25; % size of step alterng the gains
        reward_weights = [1,0.5,1]; % weight vector applied to calculate reward
        reward = 0; % reward from the last action
    end
    
    methods
        function obj = Environment(G, gain_params)
            %ENV Construct an instance of this class
            %   1. takes the Plant transfer function 
            %   2. Calculates the CLTF with passed PID gains
            obj.plant = G; 
            obj.gains = gain_params;
            obj.CLTF = get_sys(obj.plant, gain_params);
           
        end
        
        function [reward, next_state] = step(obj,action)
            % Takes one step in the environment 
            % 1. updates gains with action
            % 2. applies step response to CLTF
            % 3. gets the next state
            % 4. Calculates the new reward
            obj.gains = update_gains(obj.gains, action, obj.delta);
            obj.CLTF = get_sys(obj.plant, obj.gains);
            response = stepinfo(obj.CLTF);
            if response.Peak >= 1
                obj.state = [abs((response.Peak-1)*100), response.SettlingTime, response.RiseTime];
            else 
                obj.state = [abs((1-response.Peak)*100), response.SettlingTime, response.RiseTime];
            end
            obj.reward = -(real(dot(obj.reward_weights, obj.state)^1.1));
            reward = obj.reward;
            next_state = obj.state;
            
        end
    end
end


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
    if Kp < 0.5
        Kp = 0.5; 
    elseif Ki < 0.5
        Ki = 0.5; 
    elseif Kd < 0.5
        Kd = 0.5; 
    end
    
    out_gains = [Kp, Ki, Kd];
        
end






