function debugMode(varargin)

%==========================================================================
% debugMode - Outputs additional debug mode to the command window.
%
% Author: Noah Gula
% email address: gula.8@osu.edu
% Last revision: 23 March 2016
%==========================================================================

% Assign GUI variables
f = varargin{1};

% Get GUI data
hData = guidata(f);

% Turn on debug mode
hData.debug = 1;

% Save GUI data
guidata(f,hData);

% Debug mode turned on
fprintf('[debugMode] Debug mode turned on.\n')

end