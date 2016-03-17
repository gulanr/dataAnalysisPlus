function openPositionPlotTime(varargin)

f = varargin{1};

hData = guidata(f);

figure;
plot(hData.matFile.t,hData.matFile.s)
title('Position vs Time');
xlabel('Time (s)');
ylabel('Position (m)');

end