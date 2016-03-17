function openPowerPlotDistance(varargin)

f = varargin{1};

hData = guidata(f);

figure;
plot(hData.matFile.d,hData.matFile.Pin)
title('Power vs Distance');
xlabel('Distance (m)');
ylabel('Power (W)');

end