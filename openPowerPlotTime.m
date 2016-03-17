function openPowerPlotTime(varargin)

f = varargin{1};

hData = guidata(f);

figure;
plot(hData.matFile.t,hData.matFile.Pin)
title('Power vs Time');
xlabel('Time (s)');
ylabel('Power (W)');

end