function dataAnalysisPlus

% dataAnalysisPlus Analyzes data downloaded from the Arduino after it has
% been run. This function takes no arguments, but a .mat file must be
% supplied. This can be done by using Dustin West's AEV Analysis Tool.

%==========================================================================
% dataAnalysisPlus - Provides further data analysis on eeprom data provided
% by the AEV
%
% Author: Noah Gula
% email: gula.8@osu.edu
% 11 March 2016
%==========================================================================


% Create global variables
global t d secVelocity E file de path power Pin eepromData i I s V

% Create new figure, set to invisible until all features have been
% initialized
f = figure('Visible','off','units','pixels','outerposition',[360,250,450,285]);

% Creates line of text that provides instructions to user
hInst = uicontrol('Style','text','String','Begin by selecting .mat file.','Position',[5,220,150,20],'HorizontalAlignment','left');

% Creates push button to select .mat file
hData = uicontrol('Style','pushbutton','String','Select Data','Position',[5,200,70,25],'Callback',{@selectData_Callback},'ToolTipString','Select .mat file');

% Creates push button that closes all plots
hClose = uicontrol('Style','pushbutton','String','Close Plots','Position',[80,200,130,25],'Callback',{@close_Callback},'ToolTipString','Close all open plots');

% Creates push button that opens all plots
hOpen = uicontrol('Style','pushbutton','String','Open Plots','Position',[215,200,130,25],'Callback',{@open_Callback},'ToolTipString','Open plots');

% Removes menu bar from figure
f.MenuBar = 'none';

% Removes tool bar from figure
f.ToolBar = 'none';

% Un-hides figure
f.Visible = 'on';

    % Callback function for closing figures
    function close_Callback(source,eventdata)
        
        % Creates an array containing all open figures
        figures = findall(0,'Type','figure');
        
        % Deletes all figures except for current figure
        delete(figures(2:end))
        
        % Debug
        disp('Plots closed...')
    end
    
    % Callback function for opening plots
    function open_Callback(source,eventdata)
        
        %Create velocity plot
        vel = figure;
        plot(t,secVelocity)
        vel.Name = ['Velocity vs Time for ' file];
        title('Secant Velocity vs Time');
        xlabel('Time (s)');
        ylabel('Secant Velocity (m/s)');
        
        % Create distance plot
        dis = figure;
        plot(t,d)
        dis.Name = ['Distance vs Time for ' file];
        title('Distance vs Time');
        xlabel('Time (s)');
        ylabel('Distance (m)');
        
        % Create energy plot
        ener =  figure;
        plot(t,de)
        ener.Name = ['Energy vs Time for ' file];
        title('Incremental Energy vs Time');
        xlabel('Time (s)');
        ylabel('Incremental Energy (J)');
        
        % Create power plot
        power =  figure;
        plot(t,Pin)
        power.Name = ['Supplied Power vs Time for ' file];
        title('Supplied Power vs Time');
        xlabel('Time (s)');
        ylabel('Supplied Power (W)');
        
        % Debug
        disp('Plots opened...')
    end
    
    % Callback function for selecting .mat file
    function selectData_Callback(source,eventdata)
        
        % Asks user to select file
        [file,path] = uigetfile('*.mat','Select a file...');
        
        % Loads selected file as eepromData
        eepromData = load(file);
        
        
        
        % Convert EEProm data into physical quantities
        t = (eepromData.te)./1000; % Time (seconds)
        I = ((eepromData.ie)./1024).*2.46.*(1/.185); % Current (amps)
        V = 3.*(5.*(eepromData.ve))./(1024); % Voltage (volts)
        Pin = V.*I; % Power (watts)
        
        d = ((3.9/8).*(eepromData.marks).*.0254); % Distance (meters)
        s = ((3.9/8).*(eepromData.pos).*.0254); % Position (meters)
        
        i = 1:length((eepromData.te))-1; % Index for incremental energy
        de = zeros(length(eepromData.te),1); % Initializes empty vector
        de(i+1) = ((Pin(i) + Pin(i+1))./2).*(t(i+1)-t(i)); % Determines incremental energy
        E = sum(de); % Total energy
        
        totalTime = t(length(t)); % Calculates the total time
        avgTimeIncrement = totalTime/length(t); % Calculates the average time increment
        secVelocity = d./t; % Creates array containing the secant velocity at a time t
        
        % Displays total time
        hTTime = uicontrol('Style','text','String',['Total time = ' num2str(totalTime) ' seconds'],'Position',[5,150,300,25],'HorizontalAlignment','left');
        
        % Displays total used energy
        hTEnergy = uicontrol('Style','text','String',['Total energy = ' num2str(E) ' Joules'],'Position',[5,125,300,25],'HorizontalAlignment','left');
        
        % Allows user to select data point to analyze
        hText = uicontrol('Style','text','String','Select time: ','Position',[5,100,100,25],'HorizontalAlignment','left');
        hSelectTime = uicontrol('Style','popupmenu','String',{t(2:end)},'Position',[75,100,100,25],'Callback',{@selectTime_Callback});
        
        % Callback function for selecting point in time
        function selectTime_Callback(source,eventdata)
            
            % Defines index of selected value
            val = source.Value;
            
            % Displays velocity at that point
            hSecVel = uicontrol('Style','text','String',['Secant velocity = ' num2str(secVelocity(val)) ' m/s'],'Position',[5,75,150,25],'HorizontalAlignment','left');
            
            % Displays increments energy at that point
            hIncEner = uicontrol('Style','text','String',['Incremented energy = ' num2str(de(val)) ' J'],'Position',[5,50,300,25],'HorizontalAlignment','left');
            
            % Displays supplied power at that point
            hPower = uicontrol('Style','text','String',['Supplied Power = ' num2str(Pin(val)) ' W'],'Position',[5,25,300,25],'HorizontalAlignment','left');
            
        end
        
    end

end