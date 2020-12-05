% Copyright (2020) M. Chen, S. Chen
% L. Gong, X. Tang, S. Yuan

% You can use, modify and redistribute this 
% program under the terms of the GNU Lesser
% General Public License, either version 3 of the 
% License, or any later version.

% Simulate the whole process in a given time T
% change variables in workspace to change parameters

% Create a window
if ~exist('win','var'); win = [2,1];  end
L_wiper = min(win(1)/2,win(2));
load('./data/r02r1.mat')

if ~exist('Theta','var');Theta = pi/5;end
if ~exist('Rf','var');   Rf = 0.01;    end% 10mm wihch corresponds to the midrain
if ~exist('dt','var');    dt = 0.01;   end
if ~exist('v_car','var'); v_car = 10;   end% 32 km/h
if ~exist('r','var');   r = 1.5e-3;          end% Midian size of the rainfall
if ~exist('variance','var'); variance = 1e-4; end
if ~exist('T','var');    T = 5;            end % Time you want to simulate
if ~exist('f','var');    f = 0.5;            end %Frequency of the wiper
if ~exist('t1','var');    t1 = 0.46;            end % Time for wiper to go back and forward

raindata = {};
Ns = [];
rain_list = [0;0;0;0;0;0];     % initialy no rain

% Start simulation
t = 0;
loc = 0;       % Location of the wiper when t = 0
for i = 1 : T/dt
    N0 = length(rain_list);
    rain_list = rainer(rain_list, r,Theta,win,Rf,dt,v_car,variance);
    rain_list = mover(rain_list,dt,Theta, v_car);
    
    % Use wiper to clean the rain fall
    loc0 = loc;
    loc = wiper(loc, t, dt, f, t1);
    
    S = 0;
    ind_list = find(max([rain_list(2,:)>win(2); rain_list(2,:)<0])==1);
    if ind_list ~= 0
        rain_list(:,ind_list) = [];
    end
    
    index_to_clear = [];
    index_to_add = [];
    for j = 1: length(rain_list(1,:))
        radi = sqrt((rain_list(1,j)-win(1)/2)^2+rain_list(2,j)^2);
        if radi<= L_wiper         
            index_to_add = [index_to_add, j];
            if rain_list(1,j)>win(1)/2
                angle = atan( rain_list(2,j)/(rain_list(1,j)-win(1)/2) );
            elseif rain_list(1,j)<win(1)/2
                angle = pi-atan( rain_list(2,j)/(win(1)/2-rain_list(1,j)) );
            else
                ange = pi/2;
            end
            
            if (angle>loc0 && angle<loc) || (angle<loc0 && angle>loc)
                index_to_clear = [index_to_clear,j];
            end
        end 
    end
 
    Ss(i) = sum(pi*r02r1(rain_list(6,index_to_add)).^2);
    rain_list(:,index_to_clear) = [];
    raindata{i} = rain_list;
    t = t+dt;
end
Ss = 2*Ss./(pi*(win(1)/2)^2);
save('./data/rain_info.mat','raindata','Ss')               