% Training Parameters 
max_iter = 1000;

% Initialised PID parameters 
gains = [10,1,1];

% Transfer Function of Plant
P = tf([1,5], [1,2,3]);


reward3_hist = zeros(1, max_iter); 


del3 = 0.5;
Q_dimensions  = [length(5:del3:30), length(0.5:del3:20), length(0.5:del3:20)];
agent3 = QLearn(3,Q_dimensions,7, 1, max_iter);

env = Environment(P, gains);



for iter = 1:max_iter
    disp(agent3.epsilon);
    env.delta = del3;
    % get current state
    state = env.state;
    % choose action according to greedy policy
    action = agent3.action(env.state);
    % apply action to environment
    [reward, next_state] = env.step(action);
    % update Q-table with reward
    agent3.update_table(state, action, reward, next_state); 
    % Collect data
    reward3_hist(iter) = reward;
    % environment automatically transitions
end
response3 = env.y
save('Agent3_data', 'reward3_hist', 'del3', 'response3');


hold on 
plot(reward3_hist);
title('Reward','FontSize',18)
xlabel('Iteration','FontSize',14);

