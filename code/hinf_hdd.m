% H_infinity design for the Disk Drive System
%
nmeas = 1;
ncon = 1;
gmin = 0;
gmax = 10;
tol = 0.001;
hin_ic = sel(sys_ic,[16:18],[16:19]);
[K_hin,clp_hin,gopt] = hinfsyn(hin_ic,nmeas,ncon,gmin,gmax,tol);
gmin = 1.1*gopt;
[K_hin,clp_hin,gfin] = hinfsyn(hin_ic,nmeas,ncon,gmin,gmin,tol);
disp(' ')
minfo(K_hin)
disp(' ')
disp('Closed-loop poles')
sp = spoles(K_hin)
omega = logspace(-2,6,100);
clp_g = frsp(clp_hin,omega);
vplot('liv,lm',sel(vsvd(clp_g),1,1),'m',sel(vsvd(clp_g),2,1),'g')
title('Singular Value Plot of clp')
xlabel('Frequency (rad/sec)')
ylabel('Magnitude')
K = K_hin;
