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

% Gets current code, if there is any
code = hData.matFile.Code;

% Initialize variables for use in popup message
prompt          = {'Enter Arduino Code:'};
defaultanswer   = code;
name            = 'AEV Data Analysis Plus';
numlines        = [35 75];

% Open dialog box
code            = inputdlg(prompt,name,numlines,defaultanswer);

% Reset mat file code
hData.matFile.Code = code;

% Save GUI data
guidata(f,hData);
save([hData.matFile.fpath hData.matFile.fname],'code','-append');

end