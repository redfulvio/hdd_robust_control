% Nominal performance for four controllers
%
f = logspace(2,5,100);
w = 2*pi*f;
%
% % % % % mu-controller % % % % %
clp_mu = starp(sys_ic,K_mu);
prf_mu = sel(clp_mu,[16:17],[16:18]);
prf_mug = vnorm(frsp(prf_mu,w));
%
% % % % % % Hinf controller % % % % %
clp_hin = starp(sys_ic,K_hin);
prf_hin = sel(clp_hin,[16:17],[16:18]);
prf_hing = vnorm(frsp(prf_hin,w));
%
% % % % % % LQG controller % % % % %
clp_lqg = starp(sys_ic,K_lqg);
prf_lqg = sel(clp_lqg,[16:17],[16:18]);
prf_lqgg = vnorm(frsp(prf_lqg,w));

% % % % % PID controller % % % % %
clp_pid = starp(sys_ic,K_pid);
prf_pid = sel(clp_pid,[16:17],[16:18]);
prf_pidg = vnorm(frsp(prf_pid,w));

figure
[prf_mg,row,ind] = vunpck(prf_mug);
[prf_hfg,row,ind] = vunpck(prf_hing);
[prf_lqgg_,row,ind] = vunpck(prf_lqgg);
[prf_pidg_,row,ind] = vunpck(prf_pidg);
loglog(f,prf_mg,'r-',f,prf_hfg,'c--',f,prf_lqgg_,'m-.',f,prf_pidg_,'g')
grid
xlabel('Frequency (Hz)'), ylabel('Magnitude')
title('Nominal Performance')
legend('\mu-controller','H_\infty controller', ...
      'LQG controller','PID controller')