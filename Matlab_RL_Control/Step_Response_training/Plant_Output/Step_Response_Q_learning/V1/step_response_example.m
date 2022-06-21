

%% Design the second order plant TF 
num = [1, 5]; 
den = [1,2,3];
G = tf(num, den);

%% Design PID controller transfer function 
Kp = 13; 
Ki = 12; 
Kd = 2;
num = [Kd, Kp, Ki];
den = [1,0];
C = tf(num, den);

%% create Control System 
sys = feedback(G*C, 1);


%% Produce Step Response 
step(sys);
S = stepinfo(sys);
SSE = 1/1+S.SettlingMax; % SSE as a percentage of input
S.Overshoot; % overshoot as a percentage of input
S.SettlingTime; % settling time in seconds



