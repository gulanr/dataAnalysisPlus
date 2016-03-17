function openAccelerationPlotDistance(varargin)

f = varargin{1};

hData = guidata(f);

figure;
plot(hData.matFile.d,hData.matFile.a)
title('Acceleration vs Distance');
xlabel('Distance (m)');
ylabel('Acceleration (m/s^2)');

end