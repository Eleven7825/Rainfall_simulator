% Copyright (2020) M. Chen, S. Chen
% L. Gong, X. Tang, S. Yuan

% You can use, modify and redistribute this 
% program under the terms of the GNU Lesser
% General Public License, either version 3 of the 
% License, or any later version.

% plotter -- run the simulation by calling simulator, 
% made the video based on the data obtained by the 
% simulator

% Some constants
Fr = 20;        % Sample Rate of the video

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
disp('done!')

fprintf('Sampling the data...')
if Fr<1/dt
    N_raindata = {};
    for i = 1 : Fr*T
        N_raindata{i} = raindata{round(i/(30*dt))};
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
    Z = rain_list(5,:);
    clf
    axes('Units', 'normalized', 'Position', [0.05 0.05 .95 .95]);
    axis equal
    axis manual
    axis([0 win(1) 0 win(2)])
    for j = 1: length(X)
        c_scale = Z(j)/max_time;
        hold on
        plot(X(j),Y(j),'bo','MarkerFaceColor',[c_scale,c_scale,1])
    end
    hold off
    frame = getframe(gcf);
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
