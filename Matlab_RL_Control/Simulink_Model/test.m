
tstart = 0;
tend = 15;
global Kp
global Ki
global Kd

Kp = 5;
Ki = 1; 
Kd = 1;
simOut = sim('ModelInvertedPD1.mdl', 'StartTime', string(tstart), 'StopTime', string(tend));
position = simOut.ScopeData.signals(1); 
angle = simOut.ScopeData.signals(2);
control = simOut.ScopeData.signals(3);
t = simOut.ScopeData.time;



