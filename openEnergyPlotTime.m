function openEnergyPlotTime(varargin)

f = varargin{1};

hData = guidata(f);

figure;
plot(hData.matFile.t,hData.matFile.de)
title('Incremental Energy vs Time');
xlabel('Time (s)');
ylabel('Incremental Energy (J)');

end