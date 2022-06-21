classdef Model < handle
    %MODEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        M = 0.5;
        m = 0.2;
        b = 0.1;
        l = 0.3;
        I = 0.006;
        g = 9.8;
        F;
        X;
        
        A;
        B;
        C;
        D;
        Q;
        R;
        N;
        K;
        
        sys_ss;
        sys_tf; 
        
    end
    
    methods
        function obj = Model()
            %MODEL Construct an instance of this class
            %   Detailed explanation goes here
            p = obj.I*(obj.M+obj.m)+obj.M*obj.m*obj.l^2; %denominator for the A and B matrices

            obj.A = [0 1 0 0; 0 -(obj.I+obj.m*obj.l^2)*obj.b/p (obj.m^2*obj.g*obj.l^2)/p 0; 0 0 0 1;0 -(obj.m*obj.l*obj.b)/p obj.m*obj.g*obj.l*(obj.M+obj.m)/p 0];                  
            obj.B = [0; (obj.I+obj.m*obj.l^2)/p; 0; obj.m*obj.l/p];
            obj.C = [1 0 0 0;0 0 1 0];
            obj.D = [0; 0]; 
            obj.Q = [0.1 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 0];
            obj.R = [[0.1]];
            obj.N = zeros(4,4);
            
            states = {'x' 'x_dot' 'phi' 'phi_dot'};
            inputs = {'u'};
            outputs = {'x'; 'phi'};;
            obj.sys_ss = ss(obj.A,obj.B,obj.C, obj.D,'statename',states,'inputname',inputs,'outputname',outputs);
            obj.sys_tf = tf(obj.sys_ss);
        end
        
        function K =  get_gain_matrix(obj)
            obj.K = lqr(obj.A, obj.B, obj.Q, obj.R);
            K = obj.K;
        end
    end
end

