classdef CartPole < handle
    % An Environment Model of an Inverted Pendulum 
    properties
        % --- Pendulum Variables ---
        theta = 0 % (rad) pole angluar discplacement 
        theta_dot = 0 % (rad/s) pole angular velocity
        reward = 0;
        theta_hist;
        time;
         
        % --------- Model Parameters -------
        tau = 0.02 % time step
        M = 1.0 % (kg) mass of cart
        m = 0.1 % (kg) mass of the pendulum 
        b = 0.1 % N/m/sec coeffecient of cart 
        l = 0.5 % (m) length to pendulum centre of mass
        I = 0.006 % (kg * m^2) mass moment of inertia of the pendulum
        F = 0 % (N) force applied to cart
        force_mag = 10.0 % force pushing the cart
        g = 9.8 % (m/s^2) acceleration due to gravity
        t = 0;
        
        % ---- Controller gains ---- 
        Kp = 12;
        Ki = 1;
        Kd = 1;
        delta = 0.1;
        noise_scalar = 0.0;
        
        % ---- Pendulum limits -----
        theta_threshold = (45*pi/180)% (rad) angle threshold 
        
        % ---- environment parameters --
        step_limit = 500;
        state = [1,1,1]; % Mp, ts, norm
        lims = [0.1,0.02, 1.0];
        peak; 
        tr; 
        norm; 
        peak_bins = linspace(0,1,100);
        tr_bins = linspace(0,10,100);
        norm_bins = linspace(0,400,100);
    end

    
    
    
    methods
        function obj = CartPole()
            %  Initialise conditions
            obj.theta_dot = 0;
            obj.F = 0;
            obj.reset();
        end
        
        function reset(obj)
            obj.theta = -3*pi/180;  %start -3 degrees
            obj.theta_dot = 0; 
            obj.F = 0;
        end
        
        function [reward, next_state,  failed] = take_action(obj, action)
            % ------ This action completes the following -----
            obj.reset();
            
            % Update Gains
            [obj.Kp, obj.Ki, obj.Kd] = update_gain(action, [obj.Kp, obj.Ki, obj.Kd], obj.delta);
            % Initialise placeholders
            obj.theta_hist = zeros(1, obj.step_limit);
            obj.time = zeros(1, obj.step_limit);
            failed = 0;
            cross_flag = 0;
            max_theta = 0;
            tr = 20;
            for step = 1:obj.step_limit
                % Record time
                obj.time(step) = (step - 1) * obj.tau;
                old_sign = sign(obj.theta);
                % Calculate control force + noise
                obj.F = obj.pid() + obj.noise_scalar*normrnd(0,1);
                % Integrate Equations of motion
                if failed == 0
                    [~, y] = ode45(@(t, theta) theta_dotdot(t, theta, obj.F, obj.M, obj.m, obj.l, obj.I, obj.g), [obj.t, obj.t+obj.tau], [obj.theta; obj.theta_dot]);
                    obj.theta = y(length(y), 1);
                    obj.theta_hist(step) = obj.theta;
                    obj.theta_dot = y(length(y), 2);
                end

                % check for exceeding limits
                if abs(obj.theta) > obj.theta_threshold
                    obj.reward = 0;
                    failed = 1;
                end
                % Record angle
                obj.theta_hist(step) = obj.theta; 
                
                % get zero crossing 
                new_sign = sign(obj.theta); 
                if new_sign ~= old_sign && cross_flag == 0
                    tr = obj.time(step);
                    cross_flag = 1;
                end
                
                % Get Peak value after 0 crossing 
                if cross_flag == 1 && max_theta < abs(obj.theta) 
                    max_theta = abs(obj.theta);
                end     
            end
            
            
                
            obj.peak = max_theta; 
            obj.tr = tr; 
            obj.norm = sum(abs(obj.theta_hist));
            
            obj.state(1) = discretize(obj.peak, obj.peak_bins);
            obj.state(2) = discretize(obj.tr, obj.tr_bins);
            obj.state(3) = discretize(obj.norm, obj.norm_bins);
            
            obj.reward = -(max_theta + tr + sum(abs(obj.theta_hist)));
            reward = obj.reward; 
            next_state = obj.state;
        end

        
        function f = pid(obj)
            % e(t) --> u(t)
            prop_signal = obj.Kp * obj.theta; 
            dif_signal = obj.Kd * obj.theta_dot; 
            int_signal = obj.Ki * sum(obj.theta_hist)*obj.tau;
            f = -(prop_signal + dif_signal + int_signal);
        end
    end
end




function [Kp, Ki, Kd] = update_gain(action, in_gains, d)
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
    if Kp1 < 1.0
        Kp1 = 1.0; 
    elseif Ki1 < 0.5
        Ki1 = 0.5; 
    elseif Kd1 < 0.5
        Kd1 = 0.5; 
    end
    
    % check for any high values that could use too much force; 
    if Kp1 > 30
        Kp1 = 30; 
    elseif Ki1 > 20
        Ki1 = 20; 
    elseif Kd1 > 20
        Kd1 = 20; 
    end
    Kp = Kp1; Ki = Ki1; Kd = Kd1;    
end


