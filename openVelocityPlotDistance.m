function openVelocityPlotDistance(varargin)

f = varargin{1};

hData = guidata(f);

figure;
plot(hData.matFile.d,hData.matFile.v)
title('Velocity vs Distance');
xlabel('Distance (m)');
ylabel('Velocity (m/s)');

end