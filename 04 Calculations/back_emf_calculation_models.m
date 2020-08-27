function back_emf_calculation_models(data)
% this function takes imported data and calculates BL using different
% approaches.
% the function input is imported as a table with the following columns:
% VC1_drive_voltage
% VC2_back_emf
% cap_probe_disp
% tsec

%% calculate BL using dx/dt finite difference
% Uemf = BLv = BL(dx/dt)
% BL = Uemf/(dx/dt)
dt = data.tsec(2) - data.tsec(1);
v = diff(data.cap_probe_disp)./dt;
BL = data.VC2_back_emf(1:end-1)./v;
plot(v, BL);
BL = mean(BL)
stdBL = std(BL)
% scale the data so it's all on the same size scale?
% or loglog?
amp_cp = max(data.cap_probe_disp) - min(data.cap_probe_disp);
amp_vc1 = max(data.VC1_drive_voltage) - min(data.VC1_drive_voltage);
amp_vc2 = max(data.VC2_back_emf) - min(data.VC2_back_emf);

plot(data.tsec, data.VC1_drive_voltage./amp_vc1 - mean(data.VC1_drive_voltage./amp_vc1),...
     data.tsec, data.VC2_back_emf./amp_vc2 - mean(data.VC2_back_emf./amp_vc2),...
     data.tsec, data.cap_probe_disp./amp_cp - mean(data.cap_probe_disp./amp_cp));
 
% plot(data.tsec, data.VC1_drive_voltage + 200,...
%      data.tsec, data.VC2_back_emf + 200,...
%      data.tsec, data.cap_probe_disp + 10);
 
legend('drive voltage', 'back emf', 'cap probe')
end