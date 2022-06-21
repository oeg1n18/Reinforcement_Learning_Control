

       
         % Training Params
max_training_episodes = 100;
exp_replay_freq = 32;
copy_weights_freq = 90;
batch_size = 90;

% Create Environment 
envs = [CartPole(), CartPole(), CartPole()]; 
deltas = [0.025, 0.05, 0.1];

% Create Agents 
ddqns = [DDQN(5,7,[24,10],1,envs(1).episode_limit * max_training_episodes), DDQN(5,7,[24,10],1,envs(1).episode_limit * max_training_episodes),DDQN(5,7,[24,10],1,envs(1).episode_limit * max_training_episodes)];

% For Plotting 
episode_rewards = zeros(length(deltas), max_training_episodes);


for d_i = 1:length(deltas)
    ddqn = ddqns(d_i);
    env = envs(d_i); 
    env.delta = deltas(d_i); 
    for episode = 1:max_training_episodes
        tot_reward = 0; 
        env.reset();
        disp('Episode: ' + string(max_training_episodes*(d_i-1) + episode) + ' of delta ' + string(d_i) +' out of ' + string(length(deltas)));
        for step = 1:env.episode_limit
            % Get action 
            state = env.state; 
            action = ddqn.action(env.state);
            
            % apply action to environment 
            [reward, next_state,  failed, done] = env.take_action(action);
            
            % Store state, action, reward and next_state
            ddqn.store(state, action, reward, next_state); 
            
            % Data acquisition
            tot_reward = tot_reward + reward; 
            
            % Check for pendulum fall or completion
            if failed
                env.reset(); 
                break; 
            elseif done 
                env.reset(); 
                break;   
            end 
            
            % Train and copy weights
            if mod(step, exp_replay_freq) == 0
                ddqn.experience_replay(batch_size); 
            elseif mod(step, copy_weights_freq) == 0
                ddqn.copy_weights_agent_to_target(); 
            end
        end
        episode_rewards(d_i, episode) = tot_reward;

    end
  save('Training_variables', 'episode_rewards', 'ddqns', 'envs');
end
            
            
       
            

    
   

    
