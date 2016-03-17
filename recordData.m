function recordData(varargin)

f = varargin{1};

hData = guidata(f);

% Delete any communication interface objects
delete(instrfindall);

% Ask user for serial port
SerialPort = AskForSerialPort;

% Perform action in case of error or user quitting.
switch SerialPort
    
    case 'NONE'
        
        % Assign string to variable
        ERRORSTRING = ['Arduino Controller is not recognized. '...
            'Check the serial port in the Arduino IDE and try again.'];
        
        % Display error message
        errordlg(ERRORSTRING,'AEV Analysis Tool')
        
        return % Abort program
        
    case 'Cancel'
        
        return
        
end

% Define Serial Port
arduino = serial(SerialPort, 'BaudRate', 115200, 'terminator', 'LF');

% Open connection
fopen(arduino); drawnow; pause(.01);

% Signal the arduino to start collection and check connection
w = fscanf(arduino,'%i');

if (w == 1) % Connection successful
    
    fprintf(arduino,'%i\n',1);
    
else % Connection fails
    
    % Assign string to variable
    ERRORSTRING = ['There was an error establishing connection.'...
        ' Make sure the yellow LED on the controller is not blinking.'...
        ' If it is, disconnect the Arduino and turn the power on. Re-connect and try again'];
    
    % Display error message
    errordlg(ERRORSTRING,'AEV Analysis Tool')
    
    return; % Abort program
    
end

% Retreive the total number of elements recorder by the arduino
% May have to read several times. 
nelements = fscanf(arduino,'%f');
while (nelements == 1); nelements = fscanf(arduino,'%f'); end

% Divide by the number of variables
nelements = nelements/5;

% Initialize variables
[te,ie,ve,marks,pos] = deal( zeros(nelements,1) );

% Read in Arduino Data
for i = 1:nelements
    
    te(i)       = fscanf(arduino,'%f');
    ie(i)       = fscanf(arduino,'%f');
    ve(i)       = fscanf(arduino,'%f');
    marks(i)    = fscanf(arduino,'%f');
    pos(i)      = fscanf(arduino,'%f');
    
end

% Close serial port connection
fclose(arduino);

% Ask user if they would like to store the arduino program used.
choice = questdlg({'Would you like to store the Arduino code used for this run?'},...
    'AEV Analysis Tool','Yes','No','Yes');

drawnow; pause(0.05);  % this innocent line prevents the Matlab hang

% Perform action based on choice
switch choice
    
    case 'Yes'
        
        prompt  = {'Copy & Paste Arduino Code:'};
        name    = 'AEV Analysis Tool';
        numlines=[35 75];
        Code    = inputdlg(prompt,name,numlines); %#ok<*NASGU>
        
        drawnow; pause(0.05);  % this innocent line prevents the Matlab hang
        
    case 'No'
        
        Code = {};
        
end

% Ask user for filename
[file,path] = uiputfile('*.mat','Save As...');

% If user cancels, abort program
if file == 0
    
    return

end

% Save (.mat) file
save([path file],'te','ie','ve','marks','pos','Code')

%--------------------------------------------------------------------------
% SUBROUTINE: Ask for Serial Port
%--------------------------------------------------------------------------

    function SerialPort = AskForSerialPort(varargin)
        %==================================================================
        % AskForSerialPort: Asks user to select or enter serial port
        %
        % Author: Dustin West
        %==================================================================
        
        % Determine what operating system we are on
        switch ispc
            
            case 1 % On Windows
                
                % Get name from the Microsoft Windows registry
                ROOTKEY = 'name';
                SUBKEY  = 'HKEY_LOCAL_MACHINE';
                VALNAME = 'HARDWARE\DEVICEMAP\SERIALCOMM';
                devices = winqueryreg(ROOTKEY, SUBKEY, VALNAME);
                
                % Find current devices recognized by pc
                ROOTKEY = 'HKEY_LOCAL_MACHINE';
                SUBKEY  = 'HARDWARE\DEVICEMAP\SERIALCOMM';
                if (isempty(devices))
                    ports{1} = 'NONE';
                else
                    ports = cell(1, length(devices));
                    for ii = 1:length(devices)
                        ports{ii} = winqueryreg(ROOTKEY, SUBKEY, devices{ii});
                    end
                end
                
                % Ask user to select com port
                [selection,ok] = listdlg('PromptString','Select a Com Port:',...
                    'SelectionMode','single',...
                    'ListString',ports);
                
                drawnow; pause(0.05);  % this innocent line prevents the Matlab hang
                
                % Assign output variable
                if ok
                    SerialPort = ports{selection};
                else
                    SerialPort = 'Cancel';
                end
                
            case 0 % Assume we're on mac or linux
                
                % ask user to type in the serial port they're on
                x = inputdlg('Enter the serial port:', 'AEV Analysis Tool', [1 50]);
                
                drawnow; pause(0.05);  % this innocent line prevents the Matlab hang
                
                % User cancels
                if isempty(x)
                    SerialPort = 'Cancel';
                    return
                end
                
                % Assign output
                SerialPort = x{:};
                
        end
        
    end

end % Function