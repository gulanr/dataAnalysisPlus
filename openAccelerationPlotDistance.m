function openAccelerationPlotDistance(varargin)

%==========================================================================
% openAccelerationPlotDistance - Creates a plot of acceleration vs distance
%
% Author: Noah Gula
% email address: gula.8@osu.edu
% Last revision: 17 March 2016
%==========================================================================

% Assign GUI variables
f = varargin{1};

% Get GUI data
hData = guidata(f);

% Open new figure
figure;

% Create plot with labels
plot(hData.matFile.d,hData.matFile.a)
title('Acceleration vs Distance');
xlabel('Distance (m)');
ylabel('Acceleration (m/s^2)');

end