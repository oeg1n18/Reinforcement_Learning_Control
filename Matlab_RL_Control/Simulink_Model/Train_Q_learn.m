
% Initialize Global gain variables for Simulink Model 
globals; 

% Create Environment
env = Environment("Discrete", 0.5);


% Training Variables 
max_episodes = 1000;

% Create the Reinforcement Learning Agent
agent = QLearn(length(env.state_dimen), env.state_dimen, 7, 1, max_episodes); 

% Data Logging 
reward_hist = zeros(max_episodes, 1);
for iter = 1:max_episodes
    % get initial state
    state = env.state;
    
    % Get action from environment
    action = agent.action(state);
    
    % Apply action to environment
    [reward, next_state] = env.step(action); 
    
    % Update value Estimates
    agent.update_table(state, action, reward, next_state);
    disp(" ======================== " + string(iter) + " =====================" );
    
    % Record Data 
    reward_hist(iter) = reward;
end 

Q_time = env.time;
Q_angle = env.angle.values;
Q_reward = reward_hist;
save('Q_Training_Variables', 'Q_time', 'Q_angle', 'Q_reward');