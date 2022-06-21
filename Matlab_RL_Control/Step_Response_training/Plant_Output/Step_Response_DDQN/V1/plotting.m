

G = tf([1,5], [1,2,3]);

g = [10,1,1];
g1 = [18.25,22.75,21.00];
g2 = [9.25, 16.5, 34.25];


step(get_sys(G, g), 'b');
hold on 
step(get_sys(G, g1), 'r');
step(get_sys(G, g2), 'g');
legend('Un-tuned', 'Q-Learning Tuned', 'DDQN Tuned');
