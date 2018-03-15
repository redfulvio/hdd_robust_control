% Generate the open-loop connection for the
% Disk Drive System

% it generates the system model with uncertainties
mod_hdd

% construct performance weighting function
k = 1; % k = 1,2,3
[Wp,Wu,Wn,Wm] = weights_hdd(k);


% nominal frequency response of G
olp_ic = sel(G,16,17);
f=logspace(2,4,500);
w = 2*pi*f;
[A,B,C,D] = unpck(olp_ic);
[magp phasep] = bode(A,B,C,D,1,w);
mag = 20*log10(magp);
% figure(1)
% figure
% semilogx(f,mag,'r'), grid
% xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)')
% title('Magnitude plot of the nominal plant')
% hold off
% % figure(2)
% figure
% semilogx(f,phasep,'b'), grid
% xlabel('Frequency (Hz)'), ylabel('Phase')
% title('Phase plot of the nominal plant')


% Inverse Performance Weighting Function (Wp^-1)
f=logspace(-2,4,400);
w = 2*pi*f;
Wpi = minv(Wp);
 [A,B,C,D] = unpck(Wpi); % original
[magp phasep] = bode(A,B,C,D,1,w);
mag = 20*log10(magp);
% figure(3)
% figure
% semilogx(f,mag,'r'), grid
% xlabel('Frequency (Hz)'), ylabel('Magnitude (dB)')
% title('Inverse Performance Weighting Function (Wp^-1)')

% Control Weighting Function (Wu)
f = logspace(-2,6,100);
w = 2*pi*f;
[A,B,C,D] = unpck(Wu);    % original
[magp,phasep] = bode(A,B,C,D,1,w);
mag = 20*log10(magp);
% figure(4)
% figure
% semilogx(f,mag,'r'), grid
% title('Control Weighting Function (Wu)')
% xlabel('Frequency (Hz)')
% ylabel('Magnitude')

% Noise shaping filter frequency response (Wn)
f = logspace(-1,4,100);
w = 2*pi*f;
[A,B,C,D] = unpck(Wn);
[magp,phasep] = bode(A,B,C,D,1,w);
mynoise = ss2tf(A,B,C,D);
mag = 20*log10(magp);
% % figure(5)
% figure
% semilogx(f,mag,'r'), grid
% title('Noise shaping filter frequency response (Wn)')
% xlabel('Frequency (Hz)')
% ylabel('Magnitude')


% open-loop connection with the weighting function
systemnames = ' G Wm Wn Wp Wu ';
inputvar = '[ pert{15}; ref; dist; noise; control ]';
outputvar = '[ G(1:15); Wp; Wu; ref-G(16)-Wn ]';
input_to_G = '[ pert; dist; control ]';
input_to_Wm = '[ ref ]';
input_to_Wn = '[ noise ]';
input_to_Wp = '[ G(16) - Wm ]';
input_to_Wu = '[ control ]';
sysoutname = 'sys_ic';
cleanupsysic = 'yes';
sysic
% sys_ic -> figure 10.13