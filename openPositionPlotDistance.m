function openPositionPlotDistance(varargin)

f = varargin{1};

hData = guidata(f);

figure;
plot(hData.matFile.d,hData.matFile.s)
title('Velocity vs Distance');
xlabel('Distance (m)');
ylabel('Position (m)');

end