function dydt = theta_dotdot(t,theta, F, M, m, l, I, g)
%XDOTDOT Summary of this function goes here
%   Detailed explanation goes here
       term1 = ((-m*l*F+m^2*l^2*theta(2)^2*sin(theta(1)))/(M+m));
       term2 = -m*g*l*sin(theta(1));
       term3 = ((I+m*l^2)-((m^2*l^2*cos(theta(1)))/(M+m)));
            
        dydt = [theta(2); -(term1 + term2)/term3];
end

