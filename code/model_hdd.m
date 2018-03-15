% model transfer function frequency response

% Wm has a settling time less than 1ms and OV less than 20%
% it can be seen by rltool


f=logspace(-2,8,500);
w = 2*pi*f;
% [A,B,C,D] = unpck(Wm);
% [magp phasep] = bode(A,B,C,D,1,w);
% mag = 20*log10(magp);
% figure
% semilogx(f,mag,'k'), grid


myWm = tf([1],[3.75*(10^-9) 1.2*(10^-4) 1]);
[magp, phasep] = bode(myWm,w);
mag = 20*log10(magp);
mag = mag(:,:)';
semilogx(f,mag,'k'), grid
xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)')
title('Model M')