function closePlot(varargin)

f = varargin{1};

hData = guidata(f);

figures = findall(0,'Type','figure');
delete(figures(2:end));
disp('Plots closed')

end