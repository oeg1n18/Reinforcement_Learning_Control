classdef Environment < Model
    %ENVIRONMENT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Model;
        t = 0:0.02:10
        set_point = -0.2;
        states = {'x' 'x_dot' 'phi' 'phi_dot'};
    end
    
    methods
        function obj = Environment()
            obj.Model = Model();
        end
        
        function [y, t, x] = action(obj)
            Ac = [obj.Model.A-obj.Model.B*obj.Model.get_gain_matrix()];
            Bc = [obj.Model.B];
            Cc = [obj.Model.C];
            Dc = [obj.Model.D];
            inputs = {'r'};
            outputs = {'theta'; 'theta acceleration'};
            r = zeros(size(obj.t))+obj.set_point;
            disp(r(1:100))
            sys_cl = ss(Ac,Bc,Cc,Dc,'statename',obj.states,'inputname',inputs,'outputname',outputs);
            [y, t, x] = lsim(sys_cl, r, obj.t);
        end
    end
end

