% Copyright (2020) M. Chen, S. Chen
% L. Gong, X. Tang, S. Yuan

% You can use, modify and redistribute this 
% program under the terms of the GNU Lesser
% General Public License, either version 3 of the 
% License, or any later version.

% Calculate the raining situation for raining with
% car speed = v_car at time period dt

function rain_list = rainer(rain_list, r,Theta,win,Rf,dt,v_car,variance)
% Input:
% rain_list -- All the information about the raindrops
%                   [horizontal_cordinates; vertical_cordinates; 
%                   ...speed; acceleration]
% r             -- The radius of the raindrop before dropping
% Theta      -- The angle of the window
% win         -- size of the window: a list [width, height]
% Rf            -- rainfall (mm/h)
% dt            -- time
% v_car       -- speed of the car

% Output:
% Rain_list -- All the information about the raindrops after dt

% Some constant
g = 9.8;                    % gravity acceleration m/s^2
Cd = 0.5;                 % Drag coeffient
den_air = 1.2;          % Density of the air
den_water = 1e3;     % Density of the water

% Calculate the speed of the rainfall
v_rain = sqrt(8*den_water*g*r/(3*den_air*Cd));

% Calculate the number of new raindrops
Vol = dt*Rf*win(1)*win(2)*(sin(Theta)*v_car/v_rain+cos(Theta))/3600;
dN = 1;
r0 = [];

while Vol >= 0
    r0(dN) = normrnd(r,variance);
    Vol = Vol - 4*pi*(r0(dN)^3)/3;
    dN = dN+1;
end
dN = dN - 1;

% Calculate the speed after the fall
v_drop = 0;

% Let's rain! (update the rain list)
new_rain = [win(1)*rand(1,dN); win(2)*rand(1,dN);v_drop*ones(1, dN);zeros(1,dN);zeros(1,dN);abs(r0)];
rain_list = [rain_list,new_rain];
end