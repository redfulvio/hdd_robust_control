% mu-analysis of the Disk Drive System
%
clp_ic = starp(sys_ic,K,1,1);
%
% real perturbations
blkrsR = [-2 0;-1 1;-2 0;-1 1;-2 0;-1 1;-2 0;-1 1; ...
          -1 1;-1 1;-1 1]; 
%
% robust stability
f = logspace(3,4,100);
w = 2*pi*f;
clp_g = frsp(clp_ic,w);
rob_stab = sel(clp_g,[1:15],[1:15]);
pdim = ynum(rob_stab);
fixl = [eye(pdim); 0.01*eye(pdim)]; % 0.01% Complex
fixr = fixl';
blkrs = [blkrsR; abs(blkrsR)];
clp_mix = mmult(fixl,rob_stab,fixr);
[rbnds,rowd,sens,rowp,rowg] = mu(clp_mix,blkrs);
figure
[rbnd,row,ind] = vunpck(rbnds);
loglog(f,rbnd(:,1),'r-',f,rbnd(:,2),'m-.')
grid
xlabel('Frequency (Hz)'), ylabel('\mu')
title('Robust stability')
legend('\mu-upper bound','\mu-lower bound')
disp(' ')
disp(['mu-robust stability: ' ...
     num2str(pkvnorm(sel(rbnds,1,1)))])
disp(' ')
%
% nominal performance
f = logspace(2,4,100);
w = 2*pi*f;
clp_g = frsp(clp_ic,w);
nom_perf = vnorm(sel(clp_g,[16:17],[16:18]));
figure
[nom_prf,row,ind] = vunpck(nom_perf);
loglog(f,nom_prf,'r-')
grid
xlabel('Frequency (Hz)'), ylabel('Magnitude')
title('Nominal performance')
disp(' ')
disp(['nominal performance: ' ...
     num2str(pkvnorm(nom_perf))])
disp(' ')
%
% robust performance
f = logspace(3,4,100);
w = 2*pi*f;
clp_g = frsp(clp_ic,w);
rob_perf = clp_g;
blkrp = [blkrsR;[3 2]];
bndsrp = mu(rob_perf,blkrp);
figure
[bndrp,row,ind] = vunpck(bndsrp);
loglog(f,bndrp(:,1),'r-',f,bndrp(:,2),'m-.')
grid
xlabel('Frequency (Hz)'), ylabel('\mu')
title('Robust performance')
legend('\mu-upper bound','\mu-lower bound')
disp(' ')
disp(['mu-robust performance: ' ...
     num2str(pkvnorm(sel(bndsrp,1,1)))])
disp(' ')