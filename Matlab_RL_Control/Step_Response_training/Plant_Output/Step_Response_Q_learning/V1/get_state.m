function state = get_state(S, sys, lims)
%GET_STATE Summary of this function goes here
%   Detailed explanation goes here
    state = ones(2,1);
    
    % calculate error at 100s as a proxy for SSE
    t = 0:0.1:10;
    u = ones(101,1);
    [y,~,~] = lsim(sys,u,t);
    SSE = 1-S.SettlingMin;%abs(y(100)-1);
    
    Mp = S.Overshoot;

    if SSE < lims(1)
        state(1) = 2; 
    else 
        state(1) = 1; 
    end

    if Mp < lims(2)
        state(2) = 2; 
    else 
        state(2) = 1;

    end
end

