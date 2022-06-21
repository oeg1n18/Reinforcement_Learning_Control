tau = 0.02; % time step
M = 1.0; % (kg) mass of cart
m = 0.1; % (kg) mass of the pendulum 
b = 0.1; % N/m/sec coeffecient of cart 
l = 0.5; % (m) length to pendulum centre of mass
I = 0.006; % (kg * m^2) mass moment of inertia of the pendulum
g = 9.8; % (m/s^2) acceleration due to gravity
t = 0;

den = I*(M+m)+M*m*l^2;
A11 = -(I+m*l^2)*b/den;
A12 = m^2*g*l^2/den;
A31 = -m*l*b/den;
A32 = m*g*l*(M+m)/den;

B1 = (I+m*l^2)/den;
B3 = (m*l)/den;

A = [0 1 0 0;
     0 A11 A12 0;
     0 0 0 1;
     0 A31 A32 0];
 
B = [0; B1; 0; B3];

C = [0 0 1 0];
D = [0];