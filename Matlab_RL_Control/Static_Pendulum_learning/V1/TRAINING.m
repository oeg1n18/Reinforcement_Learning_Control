
% Training Params
max_training_episodes = 2000;
exp_replay_freq = 8;
copy_weights_freq = 30;
batch_size = 32;



% Create Environment 
env = CartPole(); 


% Create Agent 
ddqn = DDQN(3,7,[24],10,500, 'hhhhhhhhhhh');

% plotting 
reward_hist = zeros(1, max_training_episodes);

for i = 1:max_training_episodes
    
    state = env.state;
    action = ddqn.action(env.state); 
    [reward, next_state] = env.take_action(action); 
    ddqn.store(state, action, reward, next_state);
    
    % data logging 
    reward_hist(i) = reward;
    disp('iteration: ' + string(i) + '  -----  Reward: ' + string(reward) + '    -----    Gains: ' + string(env.Kp) + ' ' + string(env.Ki) + ' ' + string(env.Kd))
    
    if mod(i,exp_replay_freq) == 0
        disp('training')
        ddqn.experience_replay(batch_size);
    end
    
    if mod(i, copy_weights_freq) == 0
        ddqn.copy_weights_agent_to_target();
    end
    
    
     
end
    
