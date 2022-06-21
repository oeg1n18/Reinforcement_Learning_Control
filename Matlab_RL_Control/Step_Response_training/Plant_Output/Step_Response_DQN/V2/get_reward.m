function reward = get_reward(W,S)
%REWARD Calculates the reward from the environment.
%   Here the reward is the calculates as the weighted sum of the percentage SSE,
%   percentage overshoot and settling time.
    
    S_min = 1-S.SettlingMin;%abs(y(100)-1); % SSE as a percentage of input 
    Mp = S.Overshoot; 
    ts = S.SettlingTime;
    
    reward = -(W(1)*Mp + W(2)*S_min + W(3)*ts);
end
