% Training Params
max_training_episodes = 850;


% Create Environment 
envs = [CartPole(), CartPole(), CartPole()]; 
deltas = [0.025, 0.05, 0.1];

Q_dimensions  = [length(envs(1).Kp_bins), length(envs(1).Ki_bins), length(envs(1).Kd_bins), length(envs(1).theta_bins), length(envs(1).thetadot_bins), ];

% Create Agents 
Qs = [QLearn(5,Q_dimensions,7,1,max_training_episodes*envs(1).episode_limit),QLearn(5,Q_dimensions,7,1,max_training_episodes*envs(1).episode_limit),QLearn(5,Q_dimensions,7,1,max_training_episodes*envs(1).episode_limit)];

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
        disp(episode)
        for step = 1:env.episode_limit
            % Get action 
            state = env.state; 
            action = Q.action(env.state);
            
            % apply action to environment 
            [reward, next_state,  failed, done] = env.take_action(action);
            if ~failed 
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
        
     end
    save('Training_variables', 'Qs');
end
            
            




