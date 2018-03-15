% Frequency responses of the Hard Disk Drive Servo System
%
sim_hdd
clp = starp(sim_ic,K,1,1);
%
% closed-loop frequency response
ref_loop = sel(clp,16,16);
f = logspace(2,4,400);
w = 2*pi*f;
[A,B,C,D] = unpck(ref_loop);
[magp,phasep] = bode(A,B,C,D,1,w);
magp = 20*log10(magp);
[A,B,C,D] = unpck(Wm);
[magm,phasem] = bode(A,B,C,D,1,w);
magm = 20*log10(magm);
figure
semilogx(f,magp,'r',f,magm,'m--'), grid
xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)')
title('Closed-loop magnitude plot')
legend('Closed-loop response','Model response')
figure
semilogx(f,phasep,'b',f,phasem,'c--'), grid
xlabel('Frequency (Hz)'), ylabel('Phase (deg)')
title('Closed-loop phase plot')
legend('Closed-loop response','Model response')
%
% output sensitivity to disturbance
sen_loop = sel(clp,16,17);
f = logspace(-2,4,400);
w = 2*pi*f;
[A,B,C,D] = unpck(sen_loop);
[magp,phasep] = bode(A,B,C,D,1,w);
mag_sen = 20*log10(magp);
figure
semilogx(f,mag_sen,'r-'), grid
xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)')
title('Output sensitivity to disturbance')
%
% output sensitivity to noise
noise_loop = sel(clp,16,18);
f = logspace(0,4,400);
[A,B,C,D] = unpck(noise_loop);
[magp,phasep] = bode(A,B,C,D,1,w);
mag = 20*log10(magp);
figure
semilogx(f,mag,'r-'), grid
xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)')
title('Output sensitivity to noise')
%
% sensitivity of the control effort to the reference
ref_u = sel(clp,17,16);
f=logspace(-1,4,400);
w = 2*pi*f;
[A,B,C,D] = unpck(ref_u);
[magp,phasep] = bode(A,B,C,D,1,w);
mag = 20*log10(magp);
figure
semilogx(f,mag,'r'), grid
xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)')
title('T_{ur} magnitude plot')
%
% sensitivity of the control effort to the disturbance
dist_u = sel(clp,17,17);
f=logspace(-1,4,400);
w = 2*pi*f;
[A,B,C,D] = unpck(dist_u);
[magp,phasep] = bode(A,B,C,D,1,w);
mag = 20*log10(magp);
figure
semilogx(f,mag,'r'), grid
xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)')
title('T_{ud} magnitude plot')
%
% sensitivity of the control effort to the noise
noise_u = sel(clp,17,18);
f=logspace(-1,4,400);
w = 2*pi*f;
[A,B,C,D] = unpck(noise_u);
[magp,phasep] = bode(A,B,C,D,1,w);
mag = 20*log10(magp);
figure
semilogx(f,mag,'r'), grid
xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)')
title('T_{un} magnitude plot')
%
% controller frequency response
f=logspace(-2,6,400);
w = 2*pi*f;
[A,B,C,D] = unpck(K);
[magp,phasep] = bode(A,B,C,D,1,w);
mag = 20*log10(magp);
figure
semilogx(f,mag,'r'), grid
xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)')
title('Controller magnitude plot')
figure
semilogx(f,phasep,'b'), grid
xlabel('Frequency (Hz)'), ylabel('Phase (dB)')
title('Controller phase plot')
%
% open-loop frequency response
olp = mmult(sel(G,16,17),K);
f = logspace(-1,5,400);
w = 2*pi*f;
[A,B,C,D] = unpck(olp);
[magp,phasep] = bode(A,B,C,D,1,w);
mag = 20*log10(magp);
figure
semilogx(f,mag,'r'), grid
xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)')
title('Open-loop magnitude plot')
figure
semilogx(f,phasep,'b'), grid
xlabel('Frequency (Hz)'), ylabel('Phase (deg)')
title('Open-loop phase plot')
[Gm,Pm] = margin(ss(A,B,C,D));
Gm_dB = 20*log10(Gm);
disp(['gain margin: ' num2str(Gm_dB) 'dB'])
disp(['phase margin: ' num2str(Pm) 'deg'])
%
wts_hdd
systemnames = ' G Wm Wn ';
inputvar = '[ pert{15}; ref; dist; noise; control ]';
outputvar = '[ G(1:15); G(16)-Wm; ref-G(16); ref-G(16)-Wn ]';
input_to_G = '[ pert; dist; control ]';
input_to_Wm = '[ ref ]';
input_to_Wn = '[ noise ]';
sysoutname = 'sys';
cleanupsysic = 'yes';
sysic
%
% error frequency response
clp = starp(sys,K,1,1);
err_loop = sel(clp,17,16);
f=logspace(-2,4,400);
w = 2*pi*f;
[A,B,C,D] = unpck(err_loop);
[magp,phasep] = bode(A,B,C,D,1,w);
mag = 20*log10(magp);
figure
semilogx(f,mag,'r'), grid
xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)')
title('Error frequency response')
%
% frequency response of the difference between the
% closed-loop system and the model
clp = starp(sys,K);
dif_loop = sel(clp,16,16);
f=logspace(-2,4,400);
w = 2*pi*f;
[A,B,C,D] = unpck(dif_loop);
[magp,phasep] = bode(A,B,C,D,1,w);
mag = 20*log10(magp);
figure
semilogx(f,mag,'r'), grid
xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)')
title('System-model difference plot')
