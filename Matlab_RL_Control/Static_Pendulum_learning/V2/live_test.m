
max_steps = 30;
reward_hist = zeros(1, max_steps);
env = CartPole(); 


for i = 1:30
    action = ddqn.exploit_action(env.state); 
    [reward, next_state] = env.take_action(action); 
    reward_hist(i) = reward;
end
    