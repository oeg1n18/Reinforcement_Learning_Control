
% Training Params
max_training_episodes = 30;
steps_per_episode = 20;
exp_replay_freq = 8;
copy_weights_freq = 30;
batch_size = 48;

% Create Environment 
env = CartPole(); 
env.noise_scalar = 0.025;


% Create Agent 
ddqn = DDQN(2,7,[24],1,max_training_episodes * steps_per_episode, 'ddddddddddd');

% plotting 
hold on 
reward_hist = zeros(1, max_training_episodes * steps_per_episode);
Kp_hist = zeros(1,max_training_episodes * steps_per_episode); 
Ki_hist = zeros(1, max_training_episodes * steps_per_episode);
Kd_hist = zeros(1, max_training_episodes * steps_per_episode);
theta_hist = zeros(1, max_training_episodes * steps_per_episode);
thetadot_hist = zeros(1, max_training_episodes * steps_per_episode);
pendulum_fall_count = 0;
step_count = 0;

    
for i = 1:max_training_episodes
    tot_reward = 0;
    for step = 1:steps_per_episode
        
        step_count = step_count + 1;
        
        state = env.state;
        action = ddqn.action(env.state); 
        [reward, next_state, failed] = env.take_action(action); 
        tot_reward = tot_reward + reward;
        % Environment automatically transitions to new state
        
        
        Kp_hist((i-1)*steps_per_episode + step) = env.Kp;
        Ki_hist((i-1)*steps_per_episode + step) = env.Ki;
        Kd_hist((i-1)*steps_per_episode + step) = env.Kd;
        reward_hist((i-1)*steps_per_episode + step) = reward;
        theta_hist((i-1)*steps_per_episode + step) = env.theta;
        thetadot_hist((i-1)*steps_per_episode + step) = env.theta_dot;
        
        if failed == 1
            pendulum_fall_count = pendulum_fall_count +1; 
            env.reset(); 
            disp (' ');
            disp(' ================== PENDULUM FELL OVER ============= ' );
            disp(' ');
        end
 
        % store experiences in replay buffer
        ddqn.store(state, action, reward, next_state);


        % data logging 
        disp('Episode: ' + string(i) + ' ------ step: ' + string(step) + '  -----  Reward: ' + string(reward) + '    -----    Gains: ' + string(env.Kp) + ' ' + string(env.Ki) + ' ' + string(env.Kd) + ' ----- Epsilon: ' + string(ddqn.epsilon))

        if mod(((i-1)*max_training_episodes + step),exp_replay_freq) == 0
            disp('training')
            ddqn.experience_replay(batch_size);
            save('Training Variables', 'ddqn', 'env', 'reward_hist', 'theta_hist');

            % Live Plotting
            Plots;

            drawnow();
            saveas(gcf,'training_chart', 'jpeg')

        elseif mod(((i-1)*max_training_episodes + step), copy_weights_freq) == 0
            ddqn.copy_weights_agent_to_target();
        end
    end
    
    env.reset();
end
    
disp(' Pendulum fell ' + string(pendulum_fall_count) + ' in ' + string((max_training_episodes * steps_per_episode * env.episode_limit * env.tau)/60) + ' minutes');