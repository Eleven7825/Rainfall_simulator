% Copyright (2020) M. Chen, S. Chen
% L. Gong, X. Tang, S. Yuan

% You can use, modify and redistribute this 
% program under the terms of the GNU Lesser
% General Public License, either version 3 of the 
% License, or any later version.

% This is an easy version of plotter which uses
% the hollow circles to represent the rain drop

% plotter_fast
% Some constants

if ~exist('Fr','var');     Fr = 20;           end
fprintf('Simulate the process...')
Simulator

fprintf('\nList of variables:\n')
disp('---------------------------')
fprintf('Theta= %.3f*pi\n',Theta/pi)
fprintf('T= %.1f(s)\n',T)
fprintf('v_car= %.3f (m/s)\n',v_car)
fprintf('Rf= %.3f (m/h)\n',Rf)
fprintf('dt= %.4f (s)\n',dt)
fprintf('variance= %.4f (s)\n',variance)
fprintf('r= %.4f (m)\n',r)
fprintf('f = %.3f (t^-1)\n',f)
disp('---------------------------')
fprintf('Fram rate of the video Fr = %d\n',Fr)
disp('You can change variables in workspace!')
disp('done!')

fprintf('Sampling the data...')
if Fr<1/dt
    N_raindata = {};
    for i = 1 : Fr*T
        N_raindata{i} = raindata{round(i/(Fr*dt))};
    end
else
    N_raindata = raindata;
end
disp('done!')

fprintf('Open the video...')
myVideo = VideoWriter('./videos/window','MPEG-4');
myVideo.FrameRate = Fr;
open(myVideo)
disp('done!')
fprintf('Rendering the video...\n')

% Calculate the max time
max_time = 0;
for i = 1: length(N_raindata)
    max_time = max(max_time,max(N_raindata{i}(5,:)));
end

fprintf('+++++++++++++++++++++++++++++++++++++++++\n')
x = 0;

for i = 1: length(N_raindata)
    rain_list = N_raindata{i};
    X = rain_list(1,:);
    Y = rain_list(2,:);
    plot(X,Y,'bo')
    axis equal
    axis([0 win(1) 0 win(2)])
    frame = getframe;
    writeVideo(myVideo, frame);
    if i>=x*length(N_raindata)/40
        fprintf('+')
        x = x+1;
    end
end
fprintf('\n')
disp('done!')

fprintf('Closing the video...')
close(myVideo)
disp('done!')