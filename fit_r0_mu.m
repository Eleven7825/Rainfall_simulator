% Copyright (2020) M. Chen, S. Chen
% L. Gong, X. Tang, S. Yuan

% You can use, modify and redistribute this 
% program under the terms of the GNU Lesser
% General Public License, either version 3 of the 
% License, or any later version.

% Do regression for r0 and mu, generate the  
% relationship function in ./data

exp2data

% make the folder for the figures
if ~exist('figures','dir'); mkdir('figures'); end

% Fit: 'Fitting curve'.
[xData, yData] = prepareCurveData( r0, mu );

% Set up fittype and options.
ft = fittype( 'exp1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';

% Fit model to data.
[r02mu, gof] = fit( xData, yData, ft, opts );
save('./data/r02mu.mat','r02mu');

% Plot fit with data.
fig2 = figure( 'Name', 'Fitting curve' );
h = plot( r02mu, xData, yData );
legend( h, 'mu vs. r0', 'Fitting curve', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'r0', 'Interpreter', 'none' );
ylabel( 'mu', 'Interpreter', 'none' );
grid on
saveas(fig2, './figures/r0 vs mu.eps','epsc')


