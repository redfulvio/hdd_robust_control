% weighting control funtion Wu


% gain
gain = 10^-6;

% Wu1
nuWu1 = [0.385 1 1];
dnWu1 = [10^-4 2*(10^-3) 1];
myWu1 = nd2sys(nuWu1,dnWu1,gain);

% Wu2
nuWu2 = [0.55 1 1];
dnWu2 = [10^-4 2.1*(10^-3) 1];
myWu2 = nd2sys(nuWu2,dnWu2,gain);

% Wu3
nuWu3 = [4.05 1 1];
dnWu3 = [10^-4 2*(10^-3) 1];
myWu3 = nd2sys(nuWu3,dnWu3,3*gain);

f = logspace(-2,6,100);
w = 2*pi*f;

% Wu1
[A,B,C,D] = unpck(myWu1);
[magp,phasep] = bode(A,B,C,D,1,w);
mag = 20*log10(magp);
figure
semilogx(f,mag,'r'), grid

% Wu2
[A,B,C,D] = unpck(myWu2);
[magp,phasep] = bode(A,B,C,D,1,w);
mag = 20*log10(magp);
hold on
semilogx(f,mag,'g'), grid

% Wu3
[A,B,C,D] = unpck(myWu3);
[magp,phasep] = bode(A,B,C,D,1,w);
mag = 20*log10(magp);
hold on
semilogx(f,mag,'b'), grid

title('Control Weighting Functions')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
legend('W_{u1}','W_{u2}','W_{u3}')
legend('Location','northwest')
