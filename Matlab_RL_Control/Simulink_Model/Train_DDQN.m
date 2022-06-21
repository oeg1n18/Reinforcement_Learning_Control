% Initialize Global gain variables for Simulink Model 
globals; 

% Create Environment
env = Environment("Continuous", 0.5);


% Training Variables 
MAX_EPISODES = 1000;
EXP_REPLAY_FREQ = 4;
WEIGHT_COPY_FREQ = 16 ;
BATCH_SIZE = 32; 

% Create the Reinforcement Learning Agent
agent = DDQN(3, 7, [24],1, MAX_EPISODES); 

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
    
    % Train Value Function
    if mod(iter, EXP_REPLAY_FREQ) == 0
        agent.experience_replay(BATCH_SIZE);
        disp("             Training                ");
    elseif mod(iter, WEIGHT_COPY_FREQ) == 0
        agent.copy_weights_agent_to_target();
        disp("             Copying                 ");
    end

    disp(" ======================== " + string(iter) + " " + string(agent.epsilon) + " =====================" );
    
    % Record Data 
    reward_hist(iter) = reward;
end

    

% Save the results from testing
ddqn_time = env.time;
ddqn_angle = env.angle.values;
ddqn_reward = reward_hist;
save('DDQN_Training_Variables', 'ddqn_time', 'ddqn_angle', 'ddqn_reward');


