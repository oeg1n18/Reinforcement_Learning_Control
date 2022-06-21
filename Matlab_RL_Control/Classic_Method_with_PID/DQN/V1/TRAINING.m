

       
         % Training Params
max_training_episodes = 300;
exp_replay_freq = 64;
batch_size = 128;

% Create Environment 
envs = [CartPole(), CartPole(), CartPole()]; 
deltas = [0.025, 0.05, 0.1];

% Create Agents 
dqns = [DQN(5,7,[24,10],1,envs(1).episode_limit * max_training_episodes), DQN(5,7,[24,10],1,envs(1).episode_limit * max_training_episodes),DQN(5,7,[24,10],1,envs(1).episode_limit * max_training_episodes)];

% For Plotting 
episode_rewards = zeros(length(deltas), max_training_episodes);


for d_i = 1:length(deltas)
    dqn = dqns(d_i);
    env = envs(d_i); 
    env.delta = deltas(d_i); 
    for episode = 1:max_training_episodes
        tot_reward = 0; 
        env.reset();
        clc;
        disp('Training Episode: ' + string(episode*d_i) + ' of ' + string(length(deltas)*max_training_episodes));
        disp(episode)
        for step = 1:env.episode_limit
            % Get action 
            env.delta = deltas(d_i);
            state = env.state; 
            action = dqn.action(env.state);
            
            % apply action to environment 
            [reward, next_state,  failed, done] = env.take_action(action);
            % Store state, action, reward and next_state
            dqn.store(state, action, reward, next_state); 
            
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
                dqn.experience_replay(batch_size);  
            end
        end
        episode_rewards(d_i, episode) = tot_reward;
        
    end
    
end
save('Training_variables', 'episode_rewards', 'dqns', 'envs');     
            
       
            

    
   

    
