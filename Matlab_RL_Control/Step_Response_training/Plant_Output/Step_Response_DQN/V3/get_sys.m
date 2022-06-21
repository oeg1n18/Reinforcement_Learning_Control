function sys = get_sys(G,gains)
    %GET_SYS Gets the Control system transfer function. 
    num = gains;
    den = [1,0];
    C = tf(num, den);
    sys = C*G/(1+C*G);
end