% Copyright (2020) M. Chen, S. Chen
% L. Gong, X. Tang, S. Yuan

% You can use, modify and redistribute this 
% program under the terms of the GNU Lesser
% General Public License, either version 3 of the 
% License, or any later version.

% Calculate the location of the wiper after dt

function loc = wiper(loc, t, dt, f, t1)
% Input: 
% loc             --  Initial postion of the wiper, angle
% t                -- Total Simulate time
% f                 -- Frequency of the wiper
% dt                -- Time period to simulate
% t1                -- The time for the rain wiper to go back and forward

% Outout:
% loc               -- location of the wiper after dt, angle

T = 1/f;
if  T-t1/2 < mod(t,T) 
    loc = loc-2*pi*dt/t1;
elseif mod(t,T)>T-t1
    loc = loc+2*pi*dt/t1;
else 
    loc = 0;
end
end