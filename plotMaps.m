% Plot single activation map

% Load data from 15000 presses
load("Extracted\RandomSkin15k.mat");

n = 2000; % How many points should be used in constructing sensitivity maps?
M = 115; % Which of the 192 maps should be plotted? 
magnitudes = responsedowns(1:n,:) - responseups(1:n,:);

for i = 1:size(magnitudes, 1)
    [theta, rho] = cart2pol(positions(i,1), positions(i,2));
    % Weight based on radial position, for better visualization
    magnitudes(i,:) = abs(magnitudes(i,:)*(1.1 - (rho*1000)/70));
    magnitudes(i,:) = normalize(magnitudes(i,:));
    % Minimize effect of outliers
    magnitudes(i,:) = tanh(magnitudes(i,:));
end

% Plot active electrode positions on LHS
subplot(1,2,1);
% Load electrode positions
load("lookup192.mat");
plotProbes(lookup, M);
title(string(M));

% Plot activation map on RHS
subplot(1,2,2);
interpolant = scatteredInterpolant(positions(1:n,1),...
    positions(1:n,2),magnitudes(:,M));
[xx,yy] = meshgrid(linspace(-0.07,0.07,1000));
mag_interp = interpolant(xx,yy);
% Remove points from outside circle
for k = 1:size(xx,1)
    for j = 1:size(xx,2)
        if xx(k,j)^2 + yy(k,j)^2 > 0.07^2
            mag_interp(k,j) = nan;
        end
    end
end
contourf(xx,yy,mag_interp, 20, 'LineStyle', 'none');
xlim([-0.08 0.08]);
ylim([-0.08 0.08]);
axis square
colorbar
set(gca, 'visible', 'off');