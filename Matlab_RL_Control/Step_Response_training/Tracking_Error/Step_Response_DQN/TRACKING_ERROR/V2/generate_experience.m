function new_exp = generate_experience(N, G, W, old_exp)
%GENERATE_EXPERIENCE Summary of this function goes here
    
% initialise system
exp = old_exp;
Kp = 1; Ki = 1; Kd = 1;
sys = get_sys(G, [Kp, Ki, Kd]);
response = stepinfo(sys);
state = [response.SettlingMin, response.Overshoot, response.RiseTime, response.SettlingMax];

    for iter = 1:N
        action = randi(7);
        [Kp, Ki, Kd] = update_gains([1,1,1], action);
        sys = get_sys(G, [Kp, Ki, Kd]);
        response = stepinfo(sys);
        reward = get_reward(W,response);
        next_state = [response.SettlingMin, response.Overshoot, response.RiseTime, response.SettlingMax];
        
        % insert the experience
        exp.insert_experience(state, action, reward, next_state, rand(1,7));
    end
    
 new_exp = exp;
 disp(string(N) + " random experiences generated" );
 
        
    
end



