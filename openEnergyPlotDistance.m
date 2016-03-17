function openEnergyPlotDistance(varargin)

f = varargin{1};

hData = guidata(f);

figure;
plot(hData.matFile.d,hData.matFile.de)
title('Incremental Energy vs Distance');
xlabel('Distance (m)');
ylabel('Incremental Energy (J)');

end