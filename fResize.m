function fResize(varargin)

%==========================================================================
% fResize - Resizes and repositions the componented contained within the 
% main GUI
%
% Author: Noah Gula
% email address: gula.8@osu.edu
% Last revision: 14 Arpil 2016
%==========================================================================

% Assign GUI variables
f = varargin{1};

% Get GUI data
hData = guidata(f);

% Get position and size of main GUI
fp = get(f,'Position');

% Set height and width of textual components
height = 1/22;
width = 0.25;

% Initialize y-position
int = 0.97;

% Create array for the y-positions of all textual components
for i = 1:19
    yPos(i) = (int-i*0.05);
end

% Set position and size of labels
hData.component.totalTime.Position = [0.01 yPos(1) width height];
hData.component.totalEnergy.Position = [0.01 yPos(3) width height];
hData.component.totalDistance.Position = [0.01 yPos(5) width height];
hData.component.finalPosition.Position = [0.01 yPos(7) width height];
hData.component.averageInterval.Position = [0.01 yPos(9) width height];
hData.component.averageVelocity.Position = [0.01 yPos(11) width height];
hData.component.averageAcceleration.Position = [0.01 yPos(13) width height];
hData.component.averagePower.Position = [0.01 yPos(15) width height];
hData.component.averageEnergy.Position = [0.01 yPos(17) width height];

% Set position and size of values
hData.component.totalTimeValue.Position = [0.01 yPos(2) width height];
hData.component.totalEnergyValue.Position = [0.01 yPos(4) width height];
hData.component.totalDistanceValue.Position = [0.01 yPos(6) width height];
hData.component.finalPositionValue.Position = [0.01 yPos(8) width height];
hData.component.averageIntervalValue.Position = [0.01 yPos(10) width height];
hData.component.averageVelocityValue.Position = [0.01 yPos(12) width height];
hData.component.averageAccelerationValue.Position = [0.01 yPos(14) width height];
hData.component.averagePowerValue.Position = [0.01 yPos(16) width height];
hData.component.averageEnergyValue.Position = [0.01 yPos(18) width height];

% Position of loaded file
hData.component.loadedFile.Position = [0.01 yPos(19) width height];

% Set position and size of table
hData.component.table.Position = [0.27 0.05 0.7 0.9];

% Save position and size
guidata(f,hData);

if hData.debug
	fprintf('[fResize] Figure resized.\n');
end

end