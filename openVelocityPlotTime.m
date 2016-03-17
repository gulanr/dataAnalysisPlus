function openVelocityPlotTime(varargin)

f = varargin{1};

hData = guidata(f);

figure;
plot(hData.matFile.t,hData.matFile.v)
title('Velocity vs Time');
xlabel('Time (s)');
ylabel('Velocity (m/s)');

end