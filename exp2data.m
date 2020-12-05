% Copyright (2020) M. Chen, S. Chen
% L. Gong, X. Tang, S. Yuan

% You can use, modify and redistribute this 
% program under the terms of the GNU Lesser
% General Public License, either version 3 of the 
% License, or any later version.

% Convert the expiriment data to r0, r1 and mu

load('./data/exp.mat')
board = 28;
% Experimental results
vol = exp(:,1);
radi = exp(:,2);
height = exp(:,3);

% Convert
r0 = (3*vol./(4*pi)).^(1/3)./100;
r1 = radi./100;
mu = height./board;

% Use curve fitting tool box for next step.