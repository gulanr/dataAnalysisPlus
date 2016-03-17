function openPowerPlotTime(varargin)

%==========================================================================
% openPowerPlotTime - Creates a plot of power vs time
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
plot(hData.matFile.t,hData.matFile.Pin)
title('Power vs Time');
xlabel('Time (s)');
ylabel('Power (W)');

end