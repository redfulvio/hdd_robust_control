% Noise shaping function

nuWn = [0.1    1];
dnWn = [0.001  1];
gainWn = 0.0006;
Wn = nd2sys(nuWn,dnWn,gainWn);

f = logspace(-1,4,100);
w = 2*pi*f;
[A,B,C,D] = unpck(Wn);
[magp,phasep] = bode(A,B,C,D,1,w);
mag = 20*log10(magp);
figure
semilogx(f,mag,'k'), grid
xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)')
title('Noise Shaping Function')