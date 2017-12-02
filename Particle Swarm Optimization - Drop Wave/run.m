clear;
clf;

problem = @(x) problemfunc(x);
nvar = 2;

bound.xmin = -2;
bound.xmax = 2;
bound.vmin = 0.05*(bound.xmax-bound.xmin);
bound.vmax = -bound.vmin;

% Constriction Coeff.
k = 1; phi1 = 2.05; phi2 = 2.05;
phi = phi1+phi2;
chi = 2*k/abs(2-(phi)-sqrt(phi.^2-4*phi));

param.itermax = 50;
param.npop = 2;
param.w = chi;
param.wdamp = 0.99;
param.c1 = chi*phi1;
param.c2 = chi*phi2;

PSO(problem, nvar, bound, param)

% [X,Y] = meshgrid(bound.xmin:0.01:bound.xmax, bound.xmin:0.01:bound.xmax);
% surf(X,Y,-( 1 + cos(12.*sqrt(X.^2+Y.^2)) ) ./ ((X.^2+Y.^2)/2 + 2), 'EdgeColor','none');
% view(45,15); saveas(gcf, 'dropwave1.png');