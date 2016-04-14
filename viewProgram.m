function viewProgram(varargin)

%==========================================================================
% viewProgram - Allows the user to view or edit the program associated with
% the mat file
%
% Author: Noah Gula
% email address: gula.8@osu.edu
% Last revision: 17 March 2016
%==========================================================================

% Assign GUI variables
f = varargin{1};

% Get GUI data
hData = guidata(f);

if ~hData.fileLoaded
    
    msg = 'No file loaded. Go to File > Open EEProm File';
    title = 'AEV Data Analysis Plus';
    msgbox(msg,title);
    
    if hData.debug
        fprintf('[viewProgram] Program not loaded, functioned returned.\n');
    end
    
    return
end

% Check if there's code associate with file
if ~cell2mat(hData.matFile.Code)
    
    code = {''};
    
    if hData.debug
        fprintf('[viewProgram] No program associated with mat file.\n');
    end
else
    
    code = hData.matFile.Code;
    
    if hData.debug
        fprintf('[viewProgram] Associated code found.\n');
    end

end

if hData.debug
    fprintf('[viewProgram] Arduino code displayed.\n');
end

% Initialize variables for use in popup message
prompt          = {'Enter Arduino Code:'};
defaultanswer   = code;
name            = 'AEV Data Analysis Plus';
numlines        = [35];

% Open dialog box
code            = inputdlg(prompt,name,numlines,defaultanswer);

% Reset mat file code
hData.matFile.Code = code;

% Save GUI data
guidata(f,hData);
save([hData.matFile.fpath hData.matFile.fname],'code','-append');

end