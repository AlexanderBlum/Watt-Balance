meas_sys.poles = [-157.7,...
                  -81.5,...
                  -1.2+91*1i -1.2-91*1i,...
                  -1.9+28.4*1i -1.9-28.4*1i,...
                  29.4];
meas_sys.zeros = [-2.498+88.544*i -2.498-88.544*i,...
                  -29.665,...
                  8.68]';
[num, den] = zp2tf(meas_sys.zeros, meas_sys.poles, -825890);
measured_sys.tf = tf(num, den);

win = linspace(10^-1, 10^4, 10000);

[mag,phase,wout] = bode(measured_sys.tf, win);
% bode(measured_sys.tf)
for ii = 1:length(mag)
    mag_out(ii) = mag(1,1,ii);
end

loglog(wout, mag_out)
xlabel('Hz')
ylabel('dB Mag')
xlim([10^0 100])
ylim([10^-2 50])

hold on
[val, idx] = max(mag_out)
loglog(wout(idx), mag_out(idx), 'o')

hold off