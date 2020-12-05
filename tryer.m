% Copyright (2020) M. Chen, S. Chen
% L. Gong, X. Tang, S. Yuan

% You can use, modify and redistribute this 
% program under the terms of the GNU Lesser
% General Public License, either version 3 of the 
% License, or any later version.

% Simulate the car speed goes from 0 to 60

f = 2;
T = 20;

for v_car = 0:60
    Simulator
    mean_S= [mean_S,mean(Ss)];
    disp(v_car)
end