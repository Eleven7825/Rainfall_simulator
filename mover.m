% Copyright (2020) M. Chen, S. Chen
% L. Gong, X. Tang, S. Yuan

% You can use, modify and redistribute this 
% program under the terms of the GNU Lesser
% General Public License, either version 3 of the 
% License, or any later version.

% calculate the location of the rain drops on the 
% window after dt 

function rain_list = mover(rain_list,dt,Theta, v_car)
load('./data/r02mu.mat')
load('./data/r02r1.mat')
% constants:
den_air = 1.2;
den_water = 1e3;
g = 9.8;
Cd = 0.5; 
mu = r02mu(rain_list(6,:));
r1 = r02r1(rain_list(6,:));

for i = 1: length(rain_list(1,:))
    r = rain_list(:,i);
    % Update the acceleration
    a1 = -mu(i)*g*cos(Theta)+...
            (3*den_air*(v_car^2)*Cd/(8*den_water*r1(i)))...
            *(-mu(i)*sin(Theta)+cos(Theta))-g*sin(Theta);
        
    a2 = mu(i)*g*cos(Theta)+...
            (3*den_air*(v_car^2)*Cd/(8*den_water*r1(i)))...
            *(mu(i)*sin(Theta)+cos(Theta))-g*sin(Theta);

    if r(3) > 0
        r(4) = a1;
    elseif r(3) <0
        r(4) = a2;
    elseif r(3) == 0
        if a1>0
            r(4) = a1;
        elseif a2<0
            r(4) = a2;
        end
    end
    
    % Update the velocity
    r(3) = r(3)+r(4)*dt;
    
    % Update the y cordinate
    r(2) = r(2)+r(3)*dt;
    
    % Update the time of the rain drop
    r(5) = r(5) + dt;
    
    % update the raindrop column
    rain_list(:,i) = r;
end
