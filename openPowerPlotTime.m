function openPowerPlotTime(varargin)

%==========================================================================
% openPowerPlotTime - Creates a plot of power vs time
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
        fprintf('[openPowerPlotTime] No file loaded.\n');
    end
    
    return;
end

% Open new figure
figure;

% Create plot with labels
plot(hData.matFile.t,hData.matFile.Pin)
title('Power vs Time');
xlabel('Time (s)');
ylabel('Power (W)');

if hData.debug
	fprintf('[openPowerPlotTime] Power vs time plot opened.\n');
end

end