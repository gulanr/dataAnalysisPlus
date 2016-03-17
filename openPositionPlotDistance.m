function openPositionPlotDistance(varargin)

%==========================================================================
% openPositionPlotDistance - Creates a plot of position vs distance
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
plot(hData.matFile.d,hData.matFile.s)
title('Velocity vs Distance');
xlabel('Distance (m)');
ylabel('Position (m)');

end