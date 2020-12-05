% Copyright (2020) M. Chen, S. Chen
% L. Gong, X. Tang, S. Yuan

% You can use, modify and redistribute this 
% program under the terms of the GNU Lesser
% General Public License, either version 3 of the 
% License, or any later version.

% Do regression for r0 and r1, generate the  
% relationship function in ./data

exp2data

% Fit: 'Fitting curve'.
[xData, yData] = prepareCurveData( r0, r1 );

% Set up fittype and options.
ft = fittype( 'a*x^(1.3)', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = 0.460196475837062;

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
fig1 = figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, xData, yData );
legend( h, 'r1 vs. r0', 'untitled fit 1', 'Location', 'NorthWest', 'Interpreter', 'none' );
% Label axes
xlabel( 'r0', 'Interpreter', 'none' );
ylabel( 'r1', 'Interpreter', 'none' );
grid on

saveas(fig1,'./figures/r0_vs_r1.eps','epsc')
save('./data/r02r1.mat','r02r1');