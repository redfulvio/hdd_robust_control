% Frequency responses of all controllers
%
f = logspace(-2,6,400);
w = 2*pi*f;
%
% mu-controller
[A,B,C,D] = unpck(K_mu);
[magp,phase_mu] = bode(A,B,C,D,1,w);
mag_mu = 20*log10(magp);
%
% Hinf controller
[A,B,C,D] = unpck(K_hin);
[magp,phase_hin] = bode(A,B,C,D,1,w);
mag_hin = 20*log10(magp);
%
% Loop Shaping controller
[A,B,C,D] = unpck(K_lqg);
[magp,phase_lqg] = bode(A,B,C,D,1,w);
mag_lqg = 20*log10(magp);
%
% Loop Shaping controller
[A,B,C,D] = unpck(K_pid);
[magp,phase_pid] = bode(A,B,C,D,1,w);
mag_pid = 20*log10(magp);

%
figure
semilogx(f,mag_mu,'r-',f,mag_hin,'c--',f,mag_lqg,'m-.',f,mag_pid,'g'), grid
xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)')
title('Controller magnitude plot')
legend('\mu-controller','H_\infty controller','LQG controller','PID controller')
legend('Location','northeast')
figure
semilogx(f,phase_mu,'r-',f,phase_hin,'c--',f,phase_lqg,'m-.',f,phase_pid,'g'), grid
xlabel('Frequency (Hz)'), ylabel('Phase (deg)')
title('Controller phase plot')
legend('\mu-controller','H_\infty controller','LQG controller','PID controller')
legend('Location','northwest')