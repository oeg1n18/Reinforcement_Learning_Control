function [sys] = get_sys(G,gains)
%GET_SYS Gets the Control system transfer function. 
%   Get new control system with new parameters 

% controller
num = gains;
den = [1,0];
C = tf(num, den);
sys = G*C/(1+G*C);

end

