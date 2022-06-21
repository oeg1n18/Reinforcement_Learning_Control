function action = greedy_policy(Q_table,state,epsilon)
%GREEDY_POLICY Summary of this function goes here
%   Detailed explanation goes here
    
    if rand() > epsilon
       [~, action] = max((Q_table(state(1),state(2),:)));
    else 
        action = randi(7);
    end
end

