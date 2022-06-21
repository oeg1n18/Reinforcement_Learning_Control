% Training Params
max_training_episodes = 500;


% Create Environment 
envs = [CartPole(), CartPole(), CartPole()]; 
deltas = [0.01, 0.025, 0.05];

% Create Agents 
Qs = [QLearn(2,1000,7,1,max_training_episodes*envs(1).episode_limit),QLearn(2,1000,7,1,max_training_episodes*envs(1).episode_limit),QLearn(2,1000,7,1,max_training_episodes*envs(1).episode_limit)];

% For Plotting 
episode_rewards = zeros(length(deltas), max_training_episodes);


for d_i = 1:length(deltas)
    Q = Qs(d_i);
    Q.discount_factor = 0.9;
    env = envs(d_i); 
    env.delta = deltas(d_i); 
    for episode = 1:max_training_episodes
        tot_reward = 0; 
        env.reset();
        disp('Episode: ' + string(episode*d_i) + ' of delta ' + string(d_i) +' out of ' + string(length(deltas)));
        for step = 1:env.episode_limit
            % Get action 
            state = env.state; 
            action = Q.action(env.state);
            
            % apply action to environment 
            [reward, next_state,  failed, done] = env.take_action(action);
            if isnan(state(1) ~= 1) || isnan(state(2) ~= 1)
                Q.update_table(state, action, reward, next_state)
            end
            
            % Data acquisition
            tot_reward = tot_reward + reward; 
            % Check for pendulum fall or completion
            if failed
                env.reset(); 
                break; 
            end
            if done 
                env.reset(); 
                break;   
            end 
 
        end
        episode_rewards(d_i, episode) = tot_reward;
        save('Training_variables', 'episode_rewards', 'Qs', 'envs');
    end
    
end
            
            




