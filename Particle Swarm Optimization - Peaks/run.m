clear;
clf;

problem = @(x) problemfunc(x);
nvar = 2;

bound.xmin = -3;
bound.xmax = 3;
bound.vmin = 0.05*(bound.xmax-bound.xmin);
bound.vmax = -bound.vmin;

% Constriction Coeff.
k = 1; phi1 = 2.05; phi2 = 2.05;
phi = phi1+phi2;
chi = 2*k/abs(2-(phi)-sqrt(phi.^2-4*phi));

param.itermax = 50;
param.npop = 45;
param.w = chi;
param.wdamp = 0.99;
param.c1 = chi*phi1;
param.c2 = chi*phi2;

PSO(problem, nvar, bound, param)

% [X,Y] = meshgrid(bound.xmin:0.01:bound.xmax, bound.xmin:0.01:bound.xmax);
% surf(X,Y,3*(1-X).^2.*exp(-(X.^2) - (Y+1).^2) - 10*(X/5 - X.^3 - Y.^5).*exp(-X.^2-Y.^2) ... 
%                 - 1/3*exp(-(X+1).^2 - Y.^2), 'EdgeColor','none');
% view(40,55); saveas(gcf, 'Peak.png');