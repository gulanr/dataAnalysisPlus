function openVelocityPlotDistance(varargin)

%==========================================================================
% openVelocityPlotDistance - Creates a plot of velocity vs distance
%
% Author: Noah Gula
% email address: gula.8@osu.edu
% Last revision: 14 Arpil 2016
%==========================================================================

% Assign GUI variables
f = varargin{1};

% Get GUI data
hData = guidata(f);

if ~hData.fileLoaded
    msg = 'No file loaded. Go to File > Open EEProm file.';
    title = 'AEV Data Analysis Plus';
    msgbox(msg,title);
    
    if hData.debug
        fprintf('[openVelocityPlotDistance] No file loaded.\n');
    end
    
    return;
end

% Open new figure
figure;

% Create plot with labels
plot(hData.matFile.d,hData.matFile.v)
title('Velocity vs Distance');
xlabel('Distance (m)');
ylabel('Velocity (m/s)');

if hData.debug
	fprintf('[openVelocityPlotDistance] Velocity vs distance plot opened.\n');
end

end