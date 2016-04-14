function openEnergyPlotTime(varargin)

%==========================================================================
% openEnergyPlotTime - Creates a plot of energy vs time
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
        fprintf('[openEnergyPlotTime] No file loaded.\n');
    end
    
    return;
end


% Open new figure
figure;

% Create plot with labels
plot(hData.matFile.t,hData.matFile.de)
title('Incremental Energy vs Time');
xlabel('Time (s)');
ylabel('Incremental Energy (J)');

if hData.debug
	fprintf('[openEnergyPlotTime] Energy vs time plot opened.\n');
end

end