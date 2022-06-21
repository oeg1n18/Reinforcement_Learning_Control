
%Script Params 
max_iter = 200;


% Set Up environment
lims = [0.1,3.0,0.5];
env = Environment(P, gains, lims);
env.reward_weights = [1,1,1];



% For Plotting 
reward1_hist = zeros(1, max_iter); 
Mp1_hist = zeros(1, max_iter);
ts1_hist = zeros(1, max_iter); 
tr1_hist = zeros(1, max_iter);

reward2_hist = zeros(1, max_iter); 
Mp2_hist = zeros(1, max_iter);
ts2_hist = zeros(1, max_iter); 
tr2_hist = zeros(1, max_iter);

reward3_hist = zeros(1, max_iter); 
Mp3_hist = zeros(1, max_iter);
ts3_hist = zeros(1, max_iter); 
tr3_hist = zeros(1, max_iter);



env = Environment(P, gains, lims);
env.delta = deltas(1);
for iter = 1:max_iter
    env.delta = deltas(1);
    state = env.state;
    action = agent1.exploit_action(env.state);
    [reward, next_state] = env.step(action);

    % Collect data
    reward1_hist(iter) = reward;
    Mp1_hist(iter) = env.Mp;
    ts1_hist(iter) = env.ts;
    tr1_hist(iter) = env.tr;
end

env = Environment(P, gains, lims);
env.delta = deltas(2);
for iter = 1:max_iter
    env.delta = deltas(1);
    state = env.state;
    action = agent2.exploit_action(env.state);
    [reward, next_state] = env.step(action);

    % Collect data
    reward2_hist(iter) = reward;
    Mp2_hist(iter) = env.Mp;
    ts2_hist(iter) = env.ts;
    tr2_hist(iter) = env.tr;
end

env = Environment(P, gains, lims);
env.delta = deltas(3);
for iter = 1:max_iter
    env.delta = deltas(3);
    state = env.state;
    action = agent3.exploit_action(env.state);
    [reward, next_state] = env.step(action);

    % Collect data
    reward3_hist(iter) = reward;
    Mp3_hist(iter) = env.Mp;
    ts3_hist(iter) = env.ts;
    tr3_hist(iter) = env.tr;
end




