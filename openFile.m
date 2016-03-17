function openFile(varargin)

%==========================================================================
% openFile - Loads the .mat file and does calculations. Portions were used
% from Dustin West's tool.
%
% Author: Noah Gula, Dustin West
% email address: gula.8@osu.edu
% Last revision: 17 March 2016
%==========================================================================

% Assign GUI variables
f = varargin{1};

% Get GUI data
hData = guidata(f);

% Ask user to select file
[file,path] = uigetfile('*.mat','Select a file...');

% User cancels...
if file == 0
    return
end

% Load variables from file
md = load([path,file]);


t       = (md.te)./1000;                            % time (seconds)
I       = ((md.ie)./1024).*2.46.*(1/.185);          % Current (amps)
V       = 3.*(5.*(md.ve))./(1024);                  % Voltage (Volts)
Pin     = V.*I;                                     % Power (Watts)
d       = ((3.9/8).*(md.marks).*.0254);             % Distance traveled, Convert to meters
s       = ((3.9/8).*(md.pos).*.0254);               % Position, Convert to meters
de      = zeros(length(md.te),1);                   % Initialize vector
E       = zeros(length(t),1);                       % Initialize vector

for i = 2:length(t)-1                               % Calculate incremental energy and energy used so far (J)
    de(i+1) = ((Pin(i) + Pin(i+1))./2).*(t(i+1)-t(i));
    E(i) = sum(de);
end

E(length(t)) = sum(de);                             % Calculate total energy used (J)
v       = [0;abs(diff(d))./abs(diff(t))];           % Calculate velocity (m/s)
a       = [0;abs(diff(v))./abs(diff(t))];           % Calculate acceleration (m/s^2)
t_avg   = t(length(t))/length(t);                   % Average interval between data points (s)
v_avg   = sum(v)/length(v);                         % Average velocity (m/s)
a_avg   = sum(a)/length(a);                         % Average acceleration (m/s^2)
p_avg   = sum(Pin)/length(Pin);                     % Average power supplied (W)
e_avg   = sum(de)/length(t);                        % Average incremented energy (J)

% Prepares data to be tabulized
data = num2cell([md.te md.ie md.ve md.marks md.pos t I V d s v a Pin de E]);

% Tabulizes data
hData.component.table.Data = data;

% Displays variables in GUI
set(hData.component.totalTimeValue,'string',num2str(t(length(t))));
set(hData.component.totalEnergyValue,'string',num2str(E(length(t))))
set(hData.component.totalDistanceValue,'string',num2str(d(length(d))));
set(hData.component.finalPositionValue,'string',num2str(s(length(s))));
set(hData.component.averageIntervalValue,'string',num2str(t_avg));
set(hData.component.averageVelocityValue,'string',num2str(v_avg));
set(hData.component.averageAccelerationValue,'string',num2str(a_avg));
set(hData.component.averagePowerValue,'string',num2str(p_avg));
set(hData.component.averageEnergyValue,'string',num2str(e_avg))

% Stores data in workspace
hData.matFile.fname    = file;     % File name
hData.matFile.fpath    = path;     % Path name
hData.matFile.te       = md.te;    % Time in milliseconds
hData.matFile.ie       = md.ie;    % Current in counts
hData.matFile.ve       = md.ve;    % Voltage in counts
hData.matFile.marks    = md.marks; % Voltage in counts
hData.matFile.pos      = md.pos;   % Voltage in counts
hData.matFile.t        = t;        % Time in seconds
hData.matFile.I        = I;        % Current (amps)
hData.matFile.V        = V;        % Voltage (volts)
hData.matFile.Pin      = Pin;      % Input power (watts)
hData.matFile.d        = d;        % Cumulative distance traveled (m)
hData.matFile.s        = s;        % Position (m)
hData.matFile.a        = a;        % Acceleration (m/s^2)
hData.matFile.v        = v;        % Velocity (m/s)
hData.matFile.de       = de;       % Incremental energy
hData.matFile.E        = E;        % Total energy
hData.matFile.Code     = md.Code;  % Arduino Program
hData.matFile.t_avg    = t_avg;    % Average time interval (s)
hData.matFile.v_avg    = v_avg;    % Average velocity (m/s)
hData.matFile.a_avg    = a_avg;    % Average acceleration (m/s^2)
hData.matFile.p_avg    = p_avg;    % Average supplied power (W)
hData.matFile.e_avg    = e_avg;    % Average incremented energy (j)

% Save GUI data
guidata(f,hData);

end