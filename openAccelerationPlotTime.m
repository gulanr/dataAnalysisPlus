function openAccelerationPlotTime(varargin)

f = varargin{1};

hData = guidata(f);

figure;
plot(hData.matFile.t,hData.matFile.a)
title('Acceleration vs Time');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');

end