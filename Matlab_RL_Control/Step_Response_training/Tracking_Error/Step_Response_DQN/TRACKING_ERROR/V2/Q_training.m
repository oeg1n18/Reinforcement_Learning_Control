

%% Training Parameters 
n_gen_exp = 100;
N_iter = 2000;
W = [0,-3,8,2];
epsilon = 1; 
N_train_interval = 8;
discount_factor = 0.99;
batch_size = 32;


%% Set up Plant and CLTF
gains = [1,0.1,0.1];
% 2nd order plant 
num = [1, 5]; 
den = [1,2,3];
G = tf(num, den);
% full closed loop transfer function 
sys = get_sys(G, gains); 
response = stepinfo(sys); 
state = [response.SettlingMin, response.Overshoot, response.RiseTime, response.SettlingMax];


%% Generate Random Experiences 
exp = Experience_Replay();
exp = generate_experience(n_gen_exp, G, W, exp);


%% Create Agent  
agent = feedforwardnet([20,10]);
agent = configure(agent, transpose(exp.buffer(1:exp.index, 1:5)), rand(exp.index, 1));
agent.trainParam.showWindow = false;


%% for Data Recording
net_perform_hist = zeros(1, round(N_iter/N_train_interval));
reward_hist = zeros(1,N_iter);

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
    % store experiences 
    exp.insert_experience(state, action, reward, next_state, action_values); 
    
   
    % Q-learning every N steps
    if mod(iter, N_train_interval) == 0
        [S,A,R,S1,Q] = exp.get_batch(batch_size);
        target = transpose(Q);
        old_target = target;
        for i = 1:batch_size
            target(A(i),i) = (R(i) + discount_factor * agent();
        end
        [agent, tr] = train(agent, transpose(S), target);
        net_perform_hist(iter/N_train_interval) = tr.best_perf;
    end
    
    
    %transisition to new state 
    state = next_state; 
    iter
end























