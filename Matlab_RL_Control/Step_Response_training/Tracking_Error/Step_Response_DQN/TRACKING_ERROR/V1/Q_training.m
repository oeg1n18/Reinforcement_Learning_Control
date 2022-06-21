

%% Training Parameters 
n_gen_exp = 35;
N_iter = 2000;
W = [1,1,0,1];
epsilon = 1; 
epsilon_decay = epsilon/N_iter;
N_train_interval = 8;
discount_factor = 0.99;
batch_size = 32;


%% Set up Plant and CLTF
gains = [1,0.7,0.1];
% 2nd order plant 
num = [1, 5]; 
den = [1,2,3];
G = tf(num, den);
% full closed loop transfer function 
sys = get_sys(G, gains); 
response = stepinfo(sys); 
state = [response.SettlingMin, response.Overshoot, response.RiseTime, response.SettlingTime];


%% Generate Random Experiences 
exp = Experience_Replay();
exp = generate_experience(n_gen_exp, G, W, exp);


%% Create Agent  
agent = feedforwardnet([20,10]);
agent = configure(agent, transpose(exp.buffer(1:exp.index, 1:4)), transpose(rand(exp.index, 7)));
agent.trainParam.showWindow = false;


%% for Data Recording
net_perform_hist = zeros(1, round(N_iter/N_train_interval));
reward_hist = zeros(1,N_iter);
SettlingMin_hist = zeros(1, N_iter); 
overshoot_hist = zeros(1, N_iter); 
risetime_hist = zeros(1, N_iter); 
settling_time_hist = zeros(1, N_iter); 


%% Training
for iter = 1:N_iter
    action_values = agent(transpose(state));
    
    % Greedy policy 
    if rand() > epsilon
        [~, action] = max(action_values);
    else
        action = randi(7);
        
    end
    
    % apply action to environment 
    [next_state, reward, gains] = env(action, gains, W);
    
    reward_hist(iter) = reward;
    SettlingMin_hist(iter) = next_state(1); 
    overshoot_hist(iter) = next_state(2); 
    risetime_hist(iter) = next_state(3); 
    settling_time_hist(iter) = next_state(4);
    % store experiences 
    exp.insert_experience(state, action, reward, next_state, action_values); 
    
   
    % Q-learning every N steps
    if mod(iter, N_train_interval) == 0
        [S,A,R,S1,Q] = exp.get_batch(batch_size);
        
        for i = 1:batch_size
            q_c = agent(transpose(S(i,:)));
            q_t = R(i);
            q_t = q_t + discount_factor*max(agent(transpose(S1(i,:))));
            q_c(A(i)) = q_t;
            [agent, tr] = train(agent, transpose(S(i,:)), q_c);
        end

    end
    
    epsilon
    %transisition to new state 
    state = next_state; 
    
    % decrease exploration
    epsilon = epsilon - epsilon_decay;
    iter
end











%% Plotting
subplot(2,2,1);
plot(reward_hist);
title('Reward','FontSize',18)
xlabel('Iteration','FontSize',14);
ylim([-60,0])

subplot(2,2,2); 
plot(overshoot_hist);
title('Overshoot','FontSize',18)
ylabel('Mp (%)','FontSize',14);
xlabel('Iteration','FontSize',14);


subplot(2,2,3) 
plot(100*(1-SettlingMin_hist));
title('Settling Minimum','FontSize',18); 
xlabel('Iteration','FontSize',14);
ylabel('Settling Minimum (%)','FontSize',14);

subplot(2,2,4);
plot(settling_time_hist);
title('Settling Time','FontSize',18)
xlabel('Iteration','FontSize',14);
ylabel('time (s)','FontSize',14);









