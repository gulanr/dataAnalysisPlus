%==========================================================================
% Initialize GUI
%==========================================================================

% Create new figure, set to invisible until all components are initlialized
f = figure('Visible','off');

% Declare components
f.Units = 'normalized';
f.ToolBar = 'none';
f.MenuBar = 'none';
f.Name = 'AEV Data Analysis Plus';
f.Resize = 'on';
f.DockControls = 'off';
f.SizeChangedFcn = @fResize;

% Set position and size
f.Position = [0 0 1 1];

% Create File menu
hFMenu = uimenu;
hFMenu.Parent = f;
hFMenu.HandleVisibility = 'callback';
hFMenu.Label = 'File';

% Open file
uimenu(...
    'Parent',hFMenu,...
    'Label','Open EEProm File',...
    'Callback',{@openFile,f});

% Download data from AEV
uimenu(...
    'Parent',hFMenu,...
    'Label','Download Data From AEV',...
    'Callback',{@recordData,f});

% Create Tools menu
hTMenu = uimenu;
hTMenu.Parent = f;
hTMenu.HandleVisibility = 'callback';
hTMenu.Label = 'Tools';

% View program
uimenu(...
    'Parent',hTMenu,...
    'Label','View Arduino Program',...
    'Callback',{@viewProgram,f});

% Create Plots menu
hPMenu = uimenu;
hPMenu.Parent = f;
hPMenu.HandleVisibility = 'callback';
hPMenu.Label = 'Plots';

% Open s vs t
uimenu(...
    'Parent',hPMenu,...
    'Label','Open Position vs Time Plot',...
    'Callback',{@openPositionPlotTime,f});

% Open v vs t
uimenu(...
    'Parent',hPMenu,...
    'Label','Open Velocity vs Time Plot',...
    'Callback',{@openVelocityPlotTime,f});

% Open a vs t
uimenu(...
    'Parent',hPMenu,...
    'Label','Open Acceleration vs Time Plot',...
    'Callback',{@openAccelerationPlotTime,f});
     
% Open P vs t
uimenu(...
    'Parent',hPMenu,...
    'Label','Open Supplied Power vs Time Plot',...
    'Callback',{@openPowerPlotTime,f});
    
% Open IE vs t
uimenu(...
    'Parent',hPMenu,...
    'Label','Open Incremental Energy vs Time Plot',...
    'Separator','on',...
    'Callback',{@openEnergyPlotTime,f});

% Open s vs d
uimenu(...
    'Parent',hPMenu,...
    'Label','Open Position vs Distance Plot',...
    'Callback',{@openPositionPlotDistance,f});

% Open v vs d
uimenu(...
    'Parent',hPMenu,...
    'Label','Open Velocity vs Distance Plot',...
    'Callback',{@openVelocityPlotDistance,f});

% Open a vs d
uimenu(...
    'Parent',hPMenu,...
    'Label','Open Acceleration vs Distance Plot',...
    'Callback',{@openAccelerationPlotDistance,f});
     
% Open P vs d
uimenu(...
    'Parent',hPMenu,...
    'Label','Open Supplied Power vs Distance Plot',...
    'Callback',{@openPowerPlotDistance,f});
    
% Open IE vs d
uimenu(...
    'Parent',hPMenu,...
    'Label','Open Incremental Energy vs Distance Plot',...
    'Callback',{@openEnergyPlotDistance,f});
  
% Close all open plots
uimenu(...
    'Parent',hPMenu,...
    'Label','Close All Open Plots',...
    'Separator','on',...
    'Callback',{@closePlot,f});
    
%==========================================================================
% Construct Components
%==========================================================================
hData = guidata(f);
guidata(f,hData);

hData.component.totalTime = uicontrol(...
    'Style','text',...
    'Parent',f,...
    'Units','normalized',...
    'String','Total time',...
    'HorizontalAlignment','left',...
    'FontWeight','normal');

hData.component.totalEnergy = uicontrol(...
    'Style','text',...
    'Parent',f,...
    'Units','normalized',...
    'String','Total energy used',...
    'HorizontalAlignment','left',...
    'FontWeight','normal');

hData.component.totalDistance = uicontrol(...
    'Style','text',...
    'Parent',f,...
    'Units','normalized',...
    'String','Total distance',...
    'HorizontalAlignment','left',...
    'FontWeight','normal');

hData.component.finalPosition = uicontrol(...
    'Style','text',...
    'Parent',f,...
    'Units','normalized',...
    'String','Final position',...
    'HorizontalAlignment','left',...
    'FontWeight','normal');

hData.component.averageInterval = uicontrol(...
    'Style','text',...
    'Parent',f,...
    'Units','normalized',...
    'String','Average interval',...
    'HorizontalAlignment','left',...
    'FontWeight','normal');

hData.component.averageVelocity = uicontrol(...
    'Style','text',...
    'Parent',f,...
    'Units','normalized',...
    'String','Average velocity',...
    'HorizontalAlignment','left',...
    'FontWeight','normal');

hData.component.averageAcceleration = uicontrol(...
    'Style','text',...
    'Parent',f,...
    'Units','normalized',...
    'String','Average acceleration',...
    'HorizontalAlignment','left',...
    'FontWeight','normal');

hData.component.averagePower = uicontrol(...
    'Style','text',...
    'Parent',f,...
    'Units','normalized',...
    'String','Average supplied power',...
    'HorizontalAlignment','left',...
    'FontWeight','normal');

hData.component.averageEnergy = uicontrol(...
    'Style','text',...
    'Parent',f,...
    'Units','normalized',...
    'String','Average energy',...
    'HorizontalAlignment','left',...
    'FontWeight','normal');

hData.component.totalTimeValue = uicontrol(...
    'Style','text',...
    'Parent',f,...
    'Units','normalized',...
    'String','',...
    'HorizontalAlignment','left',...
    'BackgroundColor',[1 1 1],...
    'FontWeight','normal');

hData.component.totalEnergyValue = uicontrol(...
    'Style','text',...
    'Parent',f,...
    'Units','normalized',...
    'String','',...
    'HorizontalAlignment','left',...
    'BackgroundColor',[1 1 1],...
    'FontWeight','normal');

hData.component.totalDistanceValue = uicontrol(...
    'Style','text',...
    'Parent',f,...
    'Units','normalized',...
    'String','',...
    'HorizontalAlignment','left',...
    'BackgroundColor',[1 1 1],...
    'FontWeight','normal');

hData.component.finalPositionValue = uicontrol(...
    'Style','text',...
    'Parent',f,...
    'Units','normalized',...
    'String','',...
    'HorizontalAlignment','left',...
    'BackgroundColor',[1 1 1],...
    'FontWeight','normal');

hData.component.averageIntervalValue = uicontrol(...
    'Style','text',...
    'Parent',f,...
    'Units','normalized',...
    'String','',...
    'HorizontalAlignment','left',...
    'BackgroundColor',[1 1 1],...
    'FontWeight','normal');

hData.component.averageVelocityValue = uicontrol(...
    'Style','text',...
    'Parent',f,...
    'Units','normalized',...
    'String','',...
    'HorizontalAlignment','left',...
    'BackgroundColor',[1 1 1],...
    'FontWeight','normal');

hData.component.averageAccelerationValue = uicontrol(...
    'Style','text',...
    'Parent',f,...
    'Units','normalized',...
    'String','',...
    'HorizontalAlignment','left',...
    'BackgroundColor',[1 1 1],...
    'FontWeight','normal');

hData.component.averagePowerValue = uicontrol(...
    'Style','text',...
    'Parent',f,...
    'Units','normalized',...
    'String','',...
    'HorizontalAlignment','left',...
    'BackgroundColor',[1 1 1],...
    'FontWeight','normal');

hData.component.averageEnergyValue = uicontrol(...
    'Style','text',...
    'Parent',f,...
    'Units','normalized',...
    'String','',...
    'HorizontalAlignment','left',...
    'BackgroundColor',[1 1 1],...
    'FontWeight','normal');

%==
%
%==
columnname{1} = 'Time (ms)';
columnname{2} = 'Current (counts)';
columnname{3} = 'Voltage (counts)';
columnname{4} = 'Marks (wheel counts)';
columnname{5} = 'Relative Marks (wheel counts)';
columnname{6} = 'Time (s)';
columnname{7} = 'Current (A)';
columnname{8} = 'Voltage (V)';
columnname{9} = 'Distance (m)';
columnname{10} = 'Position (m)';
columnname{11} = 'Velocity (m/s)';
columnname{12} = 'Acceleration (m/s^2)';
columnname{13} = 'Input Power (W)';
columnname{14} = 'Incremental Energy (J)';
columnname{15} = 'Total Energy (J)';

columneditable = false(1,15);

columnformat = cell(1,15);
[columnformat{:}] = deal('numeric');

hData.component.table = uitable(...
    'Data',[],...
    'ColumnName', columnname,...
    'ColumnFormat'  , columnformat,...
    'ColumnEditable', columneditable,...
    'units','normalized');

%==
%
%==

guidata(f,hData);

f.Visible = 'on';

warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');

guidata(f,hData);

drawnow;

jFrame = get(handle(gcf),'JavaFrame');
jFrame.setMaximized(true);

message = sprintf('This tool analyzes AEV data.\n\nBegin by going to file > Open EEProm file or Download Data from AEV.\n\nContact the author, Noah Gula, at gula.8@osu.edu with questions or concerns.');
title = 'AEV Data Analysis Plus';
msg = msgbox(message,title);