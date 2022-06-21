

%% Response Criteria in % of step input 
overshoot_lim = 0.001; 
SSE_lim = 0.001;
lims = [SSE_lim, overshoot_lim];


%% Data Collection 
N = 200;
reward_hist = zeros(1,N);
Mp_hist = zeros(1,N);
SSE_hist = zeros(1,N);
ts_hist = zeros(1,N);

%% Reward Weights
% the reward is the weighted sum of the 
% Mp, SSE, ts 
W = [1,1.5,1];


%% Training Parameters 
epsilon_decay_finish = 190; 
epsilon = 1;
epsilon_grad = 1/epsilon_decay_finish;
discount_factor = 0.9; 
learning_rate = 0.2;
alpha = 0.3;


%% Control System 
Kp = 10; Ki = 1; Kd = 1;
% 2nd order plant 
num = [1, 5]; 
den = [1,2,3];
G = tf(num, den);
% full closed loop transfer function 
sys = get_sys(G, [Kp, Ki, Kd]); 
initial_response = stepinfo(sys);
state = get_state(initial_response, sys, lims); 


%% Create Q-table 
Action_space_size = 7; 
SSE_size = 2; 
Overshoot_size = 2;
Q_table = ones([SSE_size, Overshoot_size, Action_space_size]);


%% Q-Learning Algorithm
% 1. Select Action according to policy
% 2. Aplly Action to environment 
% 3. Receive the reward 
% 4. Observe the New state 
% 5. Update Q-table 
% 6. Transition to new state

disp('Training Started')
iter = 1; 
state1 = state;
while true
    iter = iter +1;
    
  

    % calculate action according to policy
    action = greedy_policy(Q_table, state, epsilon);

    % apply action to environment
    [Kp, Ki, Kd] = update_gains([Kp,Ki,Kd], action);
    sys = get_sys(G, [Kp, Ki, Kd]);
    response = stepinfo(sys);
    reward = get_reward(W, response, sys);
    
    % Collect data
    if iter < N
        reward_hist(iter) = reward;
        Mp_hist(iter) = response.Overshoot;
        ts_hist(iter) = response.SettlingTime;
        if response.SettlingMin == 0
            SSE_hist(iter) =  response.SettlingMin;
        else
            SSE_hist(iter) =  1-response.SettlingMin;
        end
    end
        

    % observe the new state
    next_state = get_state(response, sys, lims);

    % Update Q-table 
    [~, max_action] = max(Q_table(next_state(1), next_state(2), action));
    target = reward + discount_factor * Q_table(next_state(1), next_state(2), action); 
    temporal_difference = target - Q_table(state(1), state(2), action); 
    Q_table(state(1), state(2), action) = (1 - alpha)*Q_table(state(1), state(2), action) + learning_rate * temporal_difference; 

    % Transistion to new state
    state = next_state;
 
    
    % Test for terminal state
    if state(1) == 2 && state(2) == 2
        disp('Terminal State Reached in ' + string(iter) + 'iterations'); 
        break; 
    end
    
    % Check for any state transistions
    state1 = state; 
    state2 = state1;
    if state1 ~= state2 
        disp(" ====================== Transition from (" + string(state1(1)) + "," + string(state1(2)) + ") to (" + string(state2(1)) + "," + string(state2(2)) + ") ===============");
    end
    
    
    % decrease Exploration 
    epsilon = epsilon - epsilon_grad; 
    if epsilon < 0
       epsilon = 0; 
    end
    
    
    if mod(iter, 50) == 0
        %disp(" Iteration -- " + string(iter) + "      Epsilon -- " + string(epsilon));
        disp(" State ----- (" + string(state(1)) + ", " + string(state(2)) + ")");
        if iter == 5000
            disp("Unable to reach terminal state");
            break;
        end
    end
    
    if iter == N
        break;
    end
    
end 


%% Plotting
subplot(2,2,1);
plot(reward_hist);
title('Reward','FontSize',18)
xlabel('Iteration','FontSize',14);

subplot(2,2,2); 
plot(Mp_hist);
title('Overshoot','FontSize',18)
ylabel('Mp (%)','FontSize',14);
xlabel('Iteration','FontSize',14);


subplot(2,2,3) 
plot(SSE_hist);
title('Settling Minimum','FontSize',18); 
xlabel('Iteration','FontSize',14);
ylabel('Settling Minimum (%)','FontSize',14);

subplot(2,2,4);
plot(ts_hist);
title('Settling Time','FontSize',18)
xlabel('Iteration','FontSize',14);
ylabel('time (s)','FontSize',14);
