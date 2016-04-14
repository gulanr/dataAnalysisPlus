function openVelocityPlotTime(varargin)

%==========================================================================
% openVelocityPlotTime - Creates a plot of velocity vs time
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
        fprintf('[openVelocityPlotTime] No file loaded.\n');
    end
    
    return;
end

% Open new figure
figure;

% Create plot with labels
plot(hData.matFile.t,hData.matFile.v)
title('Velocity vs Time');
xlabel('Time (s)');
ylabel('Velocity (m/s)');

if hData.debug
	fprintf('[openVelocityPlotTime] Velocity vs time plot opened.\n');
end

end