% Initialize Global gain variables for Simulink Model 
globals; 

% Create Environment
env = Environment("Continuous", 0.5);


% Training Variables 
MAX_EPISODES = 1000;
EXP_REPLAY_FREQ = 8;
BATCH_SIZE = 32; 

% Create the Reinforcement Learning Agent
agent = DQN(3, 7, [24], 1, MAX_EPISODES); 

% Data Logging 
reward_hist = zeros(MAX_EPISODES, 1);
for iter = 1:MAX_EPISODES
    % get initial state
    state = env.state;
    
    % Get action from environment
    action = agent.action(state);
    
    % Apply action to environment
    [reward, next_state] = env.step(action); 
    
    % Store Transition 
    agent.store(state, action, reward, next_state);
    
    % Update value Estimates
    if mod(iter, EXP_REPLAY_FREQ) == 0
        agent.experience_replay(BATCH_SIZE);
    end
        
    
    disp(" ======================== " + string(iter) +  " " + string(reward) + " =====================" );
    
    % Record Data 
    reward_hist(iter) = reward;
end 


    
dqn_time = env.time;
dqn_angle = env.angle.values;
dqn_reward = reward_hist;
save('DQN_Training_Variables', 'dqn_time', 'dqn_angle', 'dqn_reward');