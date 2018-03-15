% Robust performance comparison for four
% controllers
%
blkrsR = [-2 0;-1 1;-2 0;-1 1;-2 0;-1 1;-2 0;-1 1; ...
          -1 1;-1 1;-1 1];
blkrp = [blkrsR;[3 2]];
f = logspace(2,5,100);
w = 2*pi*f;
%
% % % % % mu-controller % % % % %
clp_mu = starp(sys_ic,K_mu,1,1);
rbp_mu = frsp(clp_mu,w);
bnd_mu = mu(rbp_mu,blkrp);
%
% % % % % H_infinity controller % % % % %
clp_hin = starp(sys_ic,K_hin,1,1);
rbp_hin = frsp(clp_hin,w);
bnd_hin = mu(rbp_hin,blkrp);
%
% % % % % LQG controller % % % % %
clp_lqg = starp(sys_ic,K_lqg,1,1);
rbp_lqg = frsp(clp_lqg,w);
bnd_lqg = mu(rbp_lqg,blkrp);
%
% % % % % PID controller % % % % %
clp_pid = starp(sys_ic,K_pid,1,1);
rbp_pid = frsp(clp_pid,w);
bnd_pid = mu(rbp_pid,blkrp);


figure
[rbnd_mu,row,ind] = vunpck(bnd_mu);
[rbnd_hin,row,ind] = vunpck(bnd_hin);
[rbnd_lqg,row,ind] = vunpck(bnd_lqg);
[rbnd_pid,row,ind] = vunpck(bnd_pid);
loglog(f,rbnd_mu(:,1),'r-',f,rbnd_hin(:,1),'c--',f,rbnd_lqg(:,1),'m-.',f,rbnd_pid(:,1),'g')
grid
xlabel('Frequency (Hz)'), ylabel('Upper bound of \mu')
title('Robust Performance')
legend('\mu-controller','H_\infty controller', ...
      'LQG controller','PID controller')
