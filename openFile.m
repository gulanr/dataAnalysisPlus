function openFile(varargin)

f = varargin{1};

hData = guidata(f);

[file,path] = uigetfile('*.mat','Select a file...');

if file == 0
    return
end

md = load([path,file]);

% Compute input power
t       = (md.te)./1000;                            % time (seconds)
I       = ((md.ie)./1024).*2.46.*(1/.185);          % Current (amps)
V       = 3.*(5.*(md.ve))./(1024);                  % Voltage (Volts)
Pin     = V.*I;                                     % Power (Watts)

% Convert distance and position
d    = ((3.9/8).*(md.marks).*.0254);             % Distance traveled, Convert to meters
s     = ((3.9/8).*(md.pos).*.0254);               % Position, Convert to meters

% Compute incremental and total energy
de      = zeros(length(md.te),1);                   % Initialize vector
E = zeros(length(t),1);
for i = 2:length(t)-1
    de(i+1) = ((Pin(i) + Pin(i+1))./2).*(t(i+1)-t(i));
    E(i) = sum(de);
end
E(length(t)) = sum(de);

v = [0;abs(diff(d))./abs(diff(t))];
a = [0;abs(diff(v))./abs(diff(t))];

t_avg = t(length(t))/length(t);

v_avg = sum(v)/length(v);

a_avg = sum(a)/length(a);

p_avg = sum(Pin)/length(Pin);

e_avg = sum(de)/length(t);

data = num2cell([md.te md.ie md.ve md.marks md.pos t I V d s v a Pin de E]);

hData.component.table.Data = data;
set(hData.component.totalTimeValue,'string',num2str(t(length(t))));
set(hData.component.totalEnergyValue,'string',num2str(E(length(t))))
set(hData.component.totalDistanceValue,'string',num2str(d(length(d))));
set(hData.component.finalPositionValue,'string',num2str(s(length(s))));
set(hData.component.averageIntervalValue,'string',num2str(t_avg));
set(hData.component.averageVelocityValue,'string',num2str(v_avg));
set(hData.component.averageAccelerationValue,'string',num2str(a_avg));
set(hData.component.averagePowerValue,'string',num2str(p_avg));
set(hData.component.averageEnergyValue,'string',num2str(e_avg))

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
hData.matFile.d        = d;        % Cumulative distance traveled
hData.matFile.s        = s;        % Position
hData.matFile.a = a;
hData.matFile.v = v;
hData.matFile.de       = de;       % Incremental energy
hData.matFile.E        = E;        % Total energy
hData.matFile.Code     = md.Code;  % Arduino Program
hData.matFile.t_avg = t_avg;
hData.matFile.v_avg = v_avg;
hData.matFile.a_avg = a_avg;
hData.matFile.p_avg = p_avg;
hData.matFile.e_avg = e_avg;

guidata(f,hData);

end