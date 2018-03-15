% Transient responses of the closed_loop systems
% for four controllers
%
sim_hdd

% % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % % %  response to the reference% % % % % % %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % %
timedata = 0;
r = Ky;                                 % 1 track = 1 micron, r = 1.2 V 
stepdata = r;
ti = 0.000001;                          % time increment
tf = 0.0025;                            % final time value
ref = step_tr(timedata,stepdata,ti,tf);
dist = 0;
noise = 0;
pert1 = abv(0,0,0,0,0,0,0,0,0,0);
pert2 = abv(0,0,0,0,0);
pert = abv(pert1,pert2);
u = abv(pert,ref,dist,noise);
%
% % % % % mu-controller % % % % %
clp_mu = starp(sim_ic,K_mu,1,1);
y_mu = trsp(clp_mu,u,tf,ti);
yr_mu = sel(y_mu,16,1);
ur_mu = sel(y_mu,17,1);
err_mu = msub(ref,yr_mu);               % PES in Volts
errm_mu = mscl(err_mu,1/r);             % PES in tracks
%
% % % % % Hinf controller % % % % %
clp_hin = starp(sim_ic,K_hin,1,1);
y_hin = trsp(clp_hin,u,tf,ti);
yr_hin = sel(y_hin,16,1);
ur_hin = sel(y_hin,17,1);
err_hin = msub(ref,yr_hin);             % PES in Volts
errm_hin = mscl(err_hin,1/r);           % PES in tracks
%
% % Loop shaping controller
% clp_lsh = starp(sim_ic,K_lsh,1,1);
% y_lsh = trsp(clp_lsh,u,tf,ti);
% yr_lsh = sel(y_lsh,16,1);
% ur_lsh = sel(y_lsh,17,1);
% err_lsh = msub(ref,yr_lsh);             % PES in Volts
% errm_lsh = mscl(err_lsh,1/r);           % PES in tracks
%

% % % % % LQG % % % % %
clp_lqg = starp(sim_ic,K_lqg,1,1);
y_lqg = trsp(clp_lqg,u,tf,ti);
yr_lqg = sel(y_lqg,16,1);
ur_lqg = sel(y_lqg,17,1);
err_lqg = msub(ref,yr_lqg);               % PES in Volts
errm_lqg = mscl(err_lqg,1/r);             % PES in tracks


% % % % % PID % % % % %
clp_pid = starp(sim_ic,K_pid,1,1);
y_pid = trsp(clp_pid,u,tf,ti);
yr_pid = sel(y_pid,16,1);
ur_pid = sel(y_pid,17,1);
err_pid = msub(ref,yr_pid);               % PES in Volts
errm_pid = mscl(err_pid,1/r);             % PES in tracks


% figure
% vplot(errm_mu,'r-',errm_hin,'c--',errm_lqg,'m-.',errm_pid,'g')
% grid
% title('Closed-loop transient response')
% xlabel('Time (secs)')
% ylabel('Position Error Signal (tracks)')
% legend('\mu-controller','H_\infty controller', ...
%       'LQG controller', 'PID controller')

figure
plot(errm_mu(:,2),errm_mu(:,1),'r-',errm_hin(:,2),errm_hin(:,1),'b-',errm_lqg(:,2),errm_lqg(:,1),'m-',errm_pid(:,2),errm_pid(:,1),'g-'),grid
xlabel('Time (sec)'), ylabel('Position Error Signal (tracks)')
title('Closed-loop transient response')
legend('\mu-controller','H_\infty controller','LQG controller','PID controller')  

  
  
% figure
% vplot(ur_mu,'r-',ur_hin,'c--',ur_lqg,'m-.',ur_pid,'g')
% grid
% axis([0 0.0005  -1  1.5])
% title('Control action due to reference')
% xlabel('Time (secs)')
% ylabel('u (V)')
% legend('\mu-controller','H_\infty controller', ...
%       'LQG controller', 'PID controller')
  
figure
plot(ur_mu(:,2),ur_mu(:,1),'r-',ur_hin(:,2),ur_hin(:,1),'b-',ur_lqg(:,2),ur_lqg(:,1),'m-',ur_pid(:,2),ur_pid(:,1),'g-'),grid
xlabel('Time (sec)'), ylabel('u (V)')
title('Control action due to reference')
legend('\mu-controller','H_\infty controller','LQG controller','PID controller') 

% % % % % % % % % % % % % % % % % % % % % % % % % % % %   
% % % % % % % response to the disturbance % % % % % % %
% % % % % % % % % % % % % % % % % % % % % % % % % % % %
ref = 0;
% timedata = 0;
timedata = 0;
stepdata = 0.0005;                      % Td = 0.0005 N.m
ti = 0.000001;                          % time increment
tf = 0.004;                             % final time value
dist = step_tr(timedata,stepdata,ti,tf);
noise = 0;
pert1 = abv(0,0,0,0,0,0,0,0,0,0);
pert2 = abv(0,0,0,0,0);
pert = abv(pert1,pert2);
u = abv(pert,ref,dist,noise);
%
% % % % % mu-controller % % % % %
clp_mu = starp(sim_ic,K_mu,1,1);
y_mu = trsp(clp_mu,u,tf,ti);
yd_mu = sel(y_mu,16,1);
ud_mu = sel(y_mu,17,1);
err_mu = msub(ref,yd_mu);              % PES in Volts
errm_mu = mscl(err_mu,1/r);            % PES in tracks
%
% % % % % % Hinf controller % % % % %
clp_hin = starp(sim_ic,K_hin,1,1);
y_hin = trsp(clp_hin,u,tf,ti);
yd_hin = sel(y_hin,16,1);
ud_hin = sel(y_hin,17,1);
err_hin = msub(ref,yd_hin);             % PES in Volts
errm_hin = mscl(err_hin,1/r);           % PES in tracks
%
% % Loop shaping controller
% clp_lsh = starp(sim_ic,K_lsh,1,1);
% y_lsh = trsp(clp_lsh,u,tf,ti);
% yd_lsh = sel(y_lsh,16,1);
% ud_lsh = sel(y_lsh,17,1);
% err_lsh = msub(ref,yd_lsh);             % PES in Volts
% errm_lsh = mscl(err_lsh,1/r);           % PES in tracks
%
% % % % % % LQG controller % % % % %
clp_lqg = starp(sim_ic,K_lqg,1,1);
y_lqg = trsp(clp_lqg,u,tf,ti);
yd_lqg = sel(y_lqg,16,1);
ud_lqg = sel(y_lqg,17,1);
err_lqg = msub(ref,yd_lqg);             % PES in Volts
errm_lqg = mscl(err_lqg,1/r);           % PES in tracks

% % % % % % PID controller % % % % %
clp_pid = starp(sim_ic,K_pid,1,1);
y_pid = trsp(clp_pid,u,tf,ti);
yd_pid = sel(y_pid,16,1);
ud_pid = sel(y_pid,17,1);
err_pid = msub(ref,yd_pid);             % PES in Volts
errm_pid = mscl(err_pid,1/r);           % PES in tracks


% figure
% vplot(errm_mu,'r-',errm_hin,'c--',errm_lqg,'m-.',errm_pid,'g')
% grid
% title('Transient response to disturbance')
% xlabel('Time (secs)')
% ylabel('Position Error Signal (tracks)')
% legend('\mu-controller','H_\infty controller', ...
%       'LQG controller','PID controller')
  
figure
plot(errm_mu(:,2),errm_mu(:,1),'r-',errm_hin(:,2),errm_hin(:,1),'b-',errm_lqg(:,2),errm_lqg(:,1),'m-',errm_pid(:,2),errm_pid(:,1),'g-'),grid
xlabel('Time (sec)'), ylabel('Position Error Signal (tracks)')
title('Transient response to disturbance')
legend('\mu-controller','H_\infty controller','LQG controller','PID controller')
legend('Location','southwest')
  
% figure
% vplot(ud_mu,'r-',ud_hin,'c--',ud_lqg,'m-.',ud_pid,'g')
% grid
% axis([0 0.002  -0.015 0.005])
% title('Control action due to disturbance')
% xlabel('Time (secs)')
% ylabel('u (V)')
% legend('\mu-controller','H_\infty controller', ...
%       'LQG controller','PID controller')
  
figure
plot(ud_mu(:,2),ud_mu(:,1),'r-',ud_hin(:,2),ud_hin(:,1),'b-',ud_lqg(:,2),ud_lqg(:,1),'m-',ud_pid(:,2),ud_pid(:,1),'g-'),grid
xlabel('Time (sec)'), ylabel('u (V)')
title('Control action due to disturbance')
legend('\mu-controller','H_\infty controller','LQG controller','PID controller') 
  
  
  
