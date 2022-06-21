classdef CartPole < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    properties
        % --- Pendulum Variables ---
        theta = 0 % (rad) pole angluar discplacement 
        theta_dot = 0 % (rad/s) pole angular velocity 
        reward = 0;
        theta_hist;
        
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
        Kp = 10; 
        Ki = 1; 
        Kd = 1;
        delta = 0.5;
        noise_scalar = 0.0;
        
        % ---- Pendulum limits -----
        theta_threshold = (45*pi/180)% (rad) angle threshold 
        
        % ---- environment parameters --
        episode_limit = 500;
        state = [1,1,1,1];
        step = 0;
        theta_bins;
        theta_dot_bins;
        Kp_bins
        Ki_bins
        Kd_bins
    end

    
    methods
        function obj = CartPole()
            %  Initialise the variables and a radom initial pendulum angle
            obj.theta = -3*pi/180;
            obj.theta_dot = 0;
            obj.F = 0;
            obj.theta_hist = zeros(obj.episode_limit, 1);
            obj.reset();
            obj.theta_bins = linspace((-45*pi/18),(45*180/pi),100);
            obj.Kp_bins = 5:0.1:30;
            obj.Ki_bins = 0.5:0.1:20;
            obj.Kd_bins = 0.5:0.1:20;
        end
        
        function reset(obj)
            obj.theta = -5*pi/180;  %start -3 degrees
            obj.theta_dot = 0; 
            obj.theta_hist = zeros(obj.episode_limit, 1);
            obj.F = 0;
            obj.Kp = 12 ; obj.Ki = 1; obj.Kd = 1;
            obj.step = 0;
        end
        
        
        function [reward, next_state,  failed, done] = take_action(obj, action)
            % ------ This action completes the following -----
            
            % Check for episode completion
            obj.step = obj.step + 1;
            done = 0;
            failed = 0;
            if obj.step == obj.episode_limit
                obj.reset();
                obj.step = 1;
                done = 1;
            end
            
            % Update Gains
            [obj.Kp, obj.Ki, obj.Kd] = update_gain(action, [obj.Kp, obj.Ki, obj.Kd], obj.delta);
            % Calculate control force 
            obj.F = obj.pid() + obj.noise_scalar*normrnd(0,1);

            % Calculate the accelerations using the equations of motion
            % double derivatives in terms of single
            [~, y] = ode45(@(t, theta) theta_dotdot(t, theta, obj.F, obj.M, obj.m, obj.l, obj.I, obj.g), [obj.t, obj.t+obj.tau], [obj.theta; obj.theta_dot]);
            obj.theta = y(length(y), 1);
            obj.theta_hist(obj.step) = obj.theta;
            obj.theta_dot = y(length(y), 2);
        

            % check for exceeding limits
            if abs(obj.theta) > obj.theta_threshold
                obj.reset();
                obj.reward = 0;
                failed = 1;
            end
                 
            if failed == 0
                obj.reward = obj.get_reward(); 
            end
            obj.state = [discretize(obj.Kp, obj.Kp_bins), discretize(obj.Ki, obj.Ki_bins), discretize(obj.Kd, obj.Kd_bins), discretize(obj.theta, obj.theta_bins)];
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
        
        function r = get_reward(obj) 
            r = -abs(obj.theta*180/pi);
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
    if Kp1 < 5.0
        Kp1 = 5.0; 
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


