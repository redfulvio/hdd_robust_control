% weighting performance functions Wp

% gain
gain = 10^-4;

% Wp1
nuWp1 = [1 8*(10^4) 10^8];
dnWp1 = [1 7*(10^4) 2.5*(10^4)];
myWp1 = nd2sys(nuWp1,dnWp1,gain);
     
% Wp2
nuWp2 = [1 4*(10^5) 2.5*(10^9)];
dnWp2 = [1 3.9*(10^5) 6.25*(10^5)];
myWp2 = nd2sys(nuWp2,dnWp2,gain);

% Wp3
nuWp3 = [1 1.15*(10^6) 3.6*(10^10)];
dnWp3 = [1 1.05*(10^6) 9*(10^6)];
myWp3 = nd2sys(nuWp3,dnWp3,gain);

% plot

f=logspace(-2,4,400);
w = 2*pi*f;

% Wp1i
myWp1i = minv(myWp1);
[A,B,C,D] = unpck(myWp1i);
[magp,phasep] = bode(A,B,C,D,1,w);
mag = 20*log10(magp);
%mag = mag(:,:)';
figure
semilogx(f,mag,'r'), grid

% Wp2i
myWp2i = minv(myWp2);
[A,B,C,D] = unpck(myWp2i);
[magp,phasep] = bode(A,B,C,D,1,w);
mag = 20*log10(magp);
%mag = mag(:,:)';
hold on
semilogx(f,mag,'g'), grid

% Wp3i
myWp3i = minv(myWp3);
[A,B,C,D] = unpck(myWp3i);
[magp,phasep] = bode(A,B,C,D,1,w);
mag = 20*log10(magp);
%mag = mag(:,:)';
hold on
semilogx(f,mag,'b'), grid

title('Inverse Performance Weighting Functions')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
legend('Wp_1^{-1}','Wp_2^{-1}','Wp_3^{-1}')
legend('Location','northwest')

