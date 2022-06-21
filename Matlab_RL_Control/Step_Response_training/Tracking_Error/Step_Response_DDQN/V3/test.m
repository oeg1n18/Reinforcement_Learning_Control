max_iteration = 200;

% Create the Environment 
G = tf([1,5], [1,2,3]);



% Data Collection ==========================================
reward1_hist = zeros(1, max_iteration); 
Mp1_hist = zeros(1, max_iteration); 
ts1_hist = zeros(1, max_iteration); 
tr1_hist = zeros(1, max_iteration);

env = Environment(G, [10,1,1]);
env.delta = deltas(1);

for iter = 1:max_iteration
    env.delta = deltas(1);
    state = env.state;
    action = ddqn1.exploit_action(env.state);
    [reward, next_state] = env.step(action);
    reward1_hist(iter) = reward; 
    Mp1_hist(iter) = state(1);
    ts1_hist(iter) = state(2);
    tr1_hist(iter) = state(3);
end



% Data Collection ==========================================
reward2_hist = zeros(1, max_iteration); 
Mp2_hist = zeros(1, max_iteration); 
ts2_hist = zeros(1, max_iteration); 
tr2_hist = zeros(1, max_iteration);

env = Environment(G, [10,1,1]);
env.delta = deltas(2);

for iter = 1:max_iteration
    env.delta = deltas(2);
    state = env.state;
    action = ddqn2.exploit_action(env.state);
    [reward, next_state] = env.step(action);
    reward2_hist(iter) = reward; 
    Mp2_hist(iter) = state(1);
    ts2_hist(iter) = state(2);
    tr2_hist(iter) = state(3);
end



% Data Collection ==========================================
reward3_hist = zeros(1, max_iteration); 
Mp3_hist = zeros(1, max_iteration); 
ts3_hist = zeros(1, max_iteration); 
tr3_hist = zeros(1, max_iteration);

env = Environment(G, [10,1,1]);
env.delta = deltas(3);

for iter = 1:max_iteration
    env.delta = deltas(3);
    state = env.state;
    action = ddqn3.exploit_action(env.state);
    [reward, next_state] = env.step(action);
    reward3_hist(iter) = reward; 
    Mp3_hist(iter) = state(1);
    ts3_hist(iter) = state(2);
    tr3_hist(iter) = state(3);
end


disp("done");