function openPowerPlotDistance(varargin)

%==========================================================================
% openPowerPlotDistance - Creates a plot of power vs distance
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
        fprintf('[openPowerPlotDistance] No file loaded.\n');
    end
    
    return;
end


% Open new figure
figure;

% Create plot with labels
plot(hData.matFile.d,hData.matFile.Pin)
title('Power vs Distance');
xlabel('Distance (m)');
ylabel('Power (W)');

if hData.debug
	fprintf('[openPowerPlotDistance] Power vs distance plot opened.\n');
end

end