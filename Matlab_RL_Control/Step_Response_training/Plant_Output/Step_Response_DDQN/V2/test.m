max_iteration = 200;

% Create the Environment 
G = tf([1,5], [1,2,3]);
env = Environment(G, [10,1,1]);


% Data Collection 
reward_hist = zeros(3, max_iteration); 
Mp_hist = zeros(3, max_iteration); 
ts_hist = zeros(3, max_iteration); 
tr_hist = zeros(3, max_iteration);

for i = 1:3
    env = Environment(G, [10,1,1]);
    env.delta = deltas(i);
    ddqn = ddqns(i);
    for iter = 1:max_iteration
        state = env.state;
        action = ddqn.exploit_action(env.state);
        [reward, next_state] = env.step(action);
        reward_hist(i,iter) = reward; 
        Mp_hist(i,iter) = state(1);
        ts_hist(i,iter) = state(2);
        tr_hist(i,iter) = state(3);
    end
end

disp("done");