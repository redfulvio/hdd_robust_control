% Frequency responses of the Hard Disk Drive Servo System

% % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % Closed-loop frequency response % % % % %
% % % % % % % % % % % % % % % % % % % % % % % % % 
sim_hdd
f = logspace(1,4,400);
w = 2*pi*f;
%
% % % % % mu-controller % % % % %
clp_mu = starp(sim_ic,K_mu,1,1);
ref_mu = sel(clp_mu,16,16);
[A,B,C,D] = unpck(ref_mu);
[magp, phase_mu] = bode(A,B,C,D,1,w);
mag_mu = 20*log10(magp);
%
% % % % % Hinf controller % % % % %
clp_hin = starp(sim_ic,K_hin,1,1);
ref_hin = sel(clp_hin,16,16);
[A,B,C,D] = unpck(ref_hin);
[magp, phase_hin] = bode(A,B,C,D,1,w);
mag_hin = 20*log10(magp);
%
% % % % % LQG controller % % % % %
clp_lqg = starp(sim_ic,K_lqg,1,1);
ref_lqg = sel(clp_lqg,16,16);
[A,B,C,D] = unpck(ref_lqg);
[magp, phase_lsh] = bode(A,B,C,D,1,w);
mag_lqg = 20*log10(magp);
%
% % % % % PID controller % % % % %
clp_pid = starp(sim_ic,K_pid,1,1);
ref_pid = sel(clp_pid,16,16);
[A,B,C,D] = unpck(ref_pid);
[magp, phase_pid] = bode(A,B,C,D,1,w);
mag_pid = 20*log10(magp);

% model M
[A,B,C,D] = unpck(Wm);
[magp, phase_m] = bode(A,B,C,D,1,w);
mag_m = 20*log10(magp);

figure
semilogx(f,mag_mu,'r-',f,mag_hin,'c--',f,mag_lqg,'m-.',f,mag_pid,'g',f,mag_m,'k-'), grid
axis([10 10000 -10 10])
xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)')
title('Closed-loop magnitude plot')
legend('\mu-controller','H_\infty controller','LQG controller','PID controller','Model')
legend('Location','northwest')

figure
semilogx(f,phase_mu,'r-',f,phase_hin,'c--',f,phase_lsh,'m-.',f,phase_pid,'g',f,phase_m,'k-'), grid
%axis([10 1000 -150 50])
xlabel('Frequency (Hz)'), ylabel('Phase (deg)')
title('Closed-loop phase plot')
legend('\mu-controller','H_\infty controller','LQG controller','PID controller','Model')
legend('Location','northwest')



% % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % Output sensitivity to disturbance % % % % %
% % % % % % % % % % % % % % % % % % % % % % % % % % %

f = logspace(-2,4,100);
w = 2*pi*f;
%
% % % % % mu controller % % % % %
clp_mu = starp(sim_ic,K_mu,1,1);
sen_mu = sel(clp_mu,16,17);
[A,B,C,D] = unpck(sen_mu);
[magp, phasep] = bode(A,B,C,D,1,w);
mag_mu = 20*log10(magp);

% % % % % Hinf controller % % % % %
clp_hin = starp(sim_ic,K_hin,1,1);
sen_hin = sel(clp_hin,16,17);
[A,B,C,D] = unpck(sen_hin);
[magp, phasep] = bode(A,B,C,D,1,w);
mag_hin = 20*log10(magp);

% % % % % LQG controller % % % % %
clp_lqg = starp(sim_ic,K_lqg,1,1);
sen_lqg = sel(clp_lqg,16,17);
[A,B,C,D] = unpck(sen_lqg);
[magp, phasep] = bode(A,B,C,D,1,w);
mag_lqg = 20*log10(magp);

% % % % % PID controller % % % % %
clp_pid = starp(sim_ic,K_pid,1,1);
sen_pid = sel(clp_pid,16,17);
[A,B,C,D] = unpck(sen_pid);
[magp, phasep] = bode(A,B,C,D,1,w);
mag_pid = 20*log10(magp);


figure
semilogx(f,mag_mu,'r-',f,mag_hin,'c--',f,mag_lqg,'m-.',f,mag_pid,'g'), grid
xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)')
title('Output sensitivity to disturbance')
legend('\mu-controller','H_\infty controller', ...
      'LQG controller','PID controller')
  legend('Location','southeast')
  
% % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % Output sensitivity to noise % % % % % %
% % % % % % % % % % % % % % % % % % % % % % % % % % %


f = logspace(-1,4,100);
w = 2*pi*f;

% % % % % mu controller % % % % %
noise_mu = sel(clp_mu,16,18);
[A,B,C,D] = unpck(noise_mu);
[magp, phasep] = bode(A,B,C,D,1,w);
mag_mu = 20*log10(magp);

% % % % % Hinf controller % % % % %
noise_hin = sel(clp_hin,16,18);
[A,B,C,D] = unpck(noise_hin);
[magp, phasep] = bode(A,B,C,D,1,w);
mag_hin = 20*log10(magp);

% % % % % LQG controller % % % % %
noise_lqg = sel(clp_lqg,16,18);
[A,B,C,D] = unpck(noise_lqg);
[magp, phasep] = bode(A,B,C,D,1,w);
mag_lqg = 20*log10(magp);

% % % % % PID controller % % % % %
noise_pid = sel(clp_pid,16,18);
[A,B,C,D] = unpck(noise_pid);
[magp, phasep] = bode(A,B,C,D,1,w);
mag_pid = 20*log10(magp);

% noise
[A,B,C,D] = unpck(Wn);
[magp, phasep] = bode(A,B,C,D,1,w);
mag_noise = 20*log10(magp);


figure
semilogx(f,mag_mu,'r-',f,mag_hin,'c--',f,mag_lqg,'m-.',f,mag_pid,'g'), grid
xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)')
title('Output sensitivity to noise')
legend('\mu-controller','H_\infty controller', ...
      'LQG controller','PID controller')
legend('Location','northwest')