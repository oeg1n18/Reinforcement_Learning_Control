max_iteration = 200;

% Create the Environment 
G = tf([1,5], [1,2,3]);


% Data Collection 
reward_hist = zeros(1, max_iteration); 
Mp_hist = zeros(1, max_iteration); 
ts_hist = zeros(1, max_iteration); 
tr_hist = zeros(1, max_iteration);

for i = 1:3
    env = Environment(G, [10,1,1]);
    dqn = dqns(i);
    env.delta = deltas(i);
    for iter = 1:max_iteration
        state = env.state;
        action = dqn.exploit_action(env.state);
        [reward, next_state] = env.step(action);
        reward_hist(i,iter) = reward; 
        Mp_hist(i,iter) = state(1);
        ts_hist(i,iter) = state(2);
        tr_hist(i,iter) = state(3);
    end
end

% Plotting
test_plots;