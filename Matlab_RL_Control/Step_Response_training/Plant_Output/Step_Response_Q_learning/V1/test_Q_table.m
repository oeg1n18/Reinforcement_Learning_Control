
%% Information for Plotting
Kp_hist = zeros(50,1); 
Ki_hist = zeros(50,1); 
Kd_hist = zeros(50,1);
Mp_hist = zeros(50,1); 
SSE_hist = zeros(50,1); 
ts_hist = zeros(50,1);
action_hist = zeros(200,1);



%% Set Up Environment
Kp = 1; Ki = 0; Kd = 0;
sys = get_sys(G, [Kp, Ki, Kd]); 
initial_response = stepinfo(sys); 
state = get_state(initial_response, lims); 

%% Intial Gain parameters 


for iter = 1:50
    % Choose action according exploitation of Q-table
    action = greedy_policy(Q_table, state, 0); 
    
    % Apply action to envrionment 
    [Kp, Ki, Kd] = update_gains([Kp, Ki, Kd], action); 
    sys = get_sys(G, [Kp, Ki, Kd]); 
    response = stepinfo(sys); 
    reward  = get_reward(W, response);
    
    % Observe New state 
    next_state = get_state(response, lims); 
    
    % Omit Q-learning 
    
    % Record information
    Kp_hist(iter) = Kp; 
    Ki_hist(iter) = Ki; 
    Kd_hist(iter) = Kd; 
    Mp_hist(iter) = response.Overshoot;
    SSE_hist(iter) = 1/1+response.SettlingMax;
    ts_hist(iter) = response.SettlingTime;
    action_hist(iter) = action;
    
    
    
    % Transition to new state 
    state = next_state; 
end 
    
plot(Kp_hist)
sys = get_sys(G, [Kp, Ki, Kd]); 
step(sys)