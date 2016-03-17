function closePlot(varargin)
%==========================================================================
% closePlot - Closes all figures after main GUI
%
% Author: Noah Gula
% email address: gula.8@osu.edu
% Last revision: 17 March 2016
%==========================================================================

% Assign GUI variables
f = varargin{1};

% Find the main GUI's info
currentFigure = get(groot,'CurrentFigure');

% Create array of all figures
figures = findall(0,'Type','figure');

% Close all figures whose number is greater than main UI
delete(figures(currentFigure.Number+1:end));

end