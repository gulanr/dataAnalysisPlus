function openEnergyPlotDistance(varargin)

%==========================================================================
% openEnergyPlotDistance - Creates a plot of energy usage vs distance
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
plot(hData.matFile.d,hData.matFile.de)
title('Incremental Energy vs Distance');
xlabel('Distance (m)');
ylabel('Incremental Energy (J)');

end