% Robust stability of the closed-loop system
% for the Hard Disk Drive System
%
f = logspace(2,5,100);
w = 2*pi*f;
% Real perturbations
blkrsR = [-2 0;-1 1;-2 0;-1 1;-2 0;-1 1;-2 0;-1 1; ...
          -1 1;-1 1;-1 1];
blkrs = [blkrsR; abs(blkrsR)];
%
% % % % % mu-controller % % % % %
clp_mu = starp(sys_ic,K_mu);
clp_mug = frsp(clp_mu,w);
rob_stab = sel(clp_mug,[1:15],[1:15]);
pdim = ynum(rob_stab);
fixl = [eye(pdim); 0.01*eye(pdim)]; % 0.01% Complex
fixr = fixl';
clp_mix = mmult(fixl,rob_stab,fixr);
rbnds_mu = mu(clp_mix,blkrs);
%
% % % % % Hinf controller % % % % %
clp_hin = starp(sys_ic,K_hin);
clp_hing = frsp(clp_hin,w);
rob_stab = sel(clp_hing,[1:15],[1:15]);
pdim = ynum(rob_stab);
fixl = [eye(pdim); 0.01*eye(pdim)]; % 0.01% Complex
fixr = fixl';
clp_mix = mmult(fixl,rob_stab,fixr);
rbnds_hin = mu(clp_mix,blkrs);
%
% % % % % LQG controller % % % % %
clp_lqg = starp(sys_ic,K_lqg);
clp_lqgg = frsp(clp_lqg,w);
rob_stab = sel(clp_lqgg,[1:15],[1:15]);
pdim = ynum(rob_stab);
fixl = [eye(pdim); 0.01*eye(pdim)]; % 0.01% Complex
fixr = fixl';
clp_mix = mmult(fixl,rob_stab,fixr);
rbnds_lqg = mu(clp_mix,blkrs);
%
% % % % % PID controller % % % % %
clp_pid = starp(sys_ic,K_pid);
clp_pidg = frsp(clp_pid,w);
rob_stab = sel(clp_pidg,[1:15],[1:15]);
pdim = ynum(rob_stab);
fixl = [eye(pdim); 0.01*eye(pdim)]; % 0.01% Complex
fixr = fixl';
clp_mix = mmult(fixl,rob_stab,fixr);
rbnds_pid = mu(clp_mix,blkrs);


figure
[rbnd_mu,row,ind] = vunpck(rbnds_mu);
[rbnd_hin,row,ind] = vunpck(rbnds_hin);
[rbnd_lqg,row,ind] = vunpck(rbnds_lqg);
[rbnd_pid,row,ind] = vunpck(rbnds_pid);

semilogx(f,rbnd_mu(:,1),'r-',f,rbnd_hin(:,1),'c--',f,rbnd_lqg(:,1),'m-.',f,rbnd_pid(:,1),'g')
% semilogx(f,rbnd_mu(:,1),'r-',f,rbnd_hin(:,1),'c--')
grid
xlabel('Frequency (Hz)'), ylabel('Upper bound of \mu')
title('Robust Stability')
legend('\mu-controller','H_\infty controller', ...
      'LQG controller','PID controller')