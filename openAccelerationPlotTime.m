function openAccelerationPlotTime(varargin)

%==========================================================================
% openAccelerationPlotTime - Creates a plot of acceleration vs time
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
plot(hData.matFile.t,hData.matFile.a)
title('Acceleration vs Time');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');

end