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







