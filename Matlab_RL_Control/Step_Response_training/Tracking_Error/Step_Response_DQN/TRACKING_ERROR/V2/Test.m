


limit = 10; 
gains = [3,1,1];
% 2nd order plant 
num = [1, 5]; 
den = [1,2,3];
G = tf(num, den);
% full closed loop transfer function 
sys = get_sys(G, gains); 
response = stepinfo(sys); 
state = [response.SettlingMin, response.Overshoot, response.RiseTime, response.SettlingMax];


reward_hist = zeros(1,limit);
action_hist = zeros(1, limit);
Kp_hist = zeros(1, limit);
Ki_hist = zeros(1, limit);
Kd_hist = zeros(1, limit);

for i = 1:limit 
    action_values = agent(transpose(state)); 
    [~, action] = max(action_values); 
    [next_state, reward, gains] = env(action, gains, W); 
    reward_hist(i) = reward;
    action_hist(i) = action;
    Kp_hist(i) = gains(1); 
    Ki_hist(i) = gains(2); 
    Kd_hist(i) = gains(3);
    state = next_state; 
    
end
    
plot(reward_hist);