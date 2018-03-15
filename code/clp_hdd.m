% Transient responses of the closed_loop system
%
% response to the reference
sim_hdd
clp = starp(sim_ic,K,1,1);
timedata = 0;
r = Ky;                                 % 1 track --> 1.2 V 
stepdata = r;
ti = 0.000001;                          % time increment
tff = 0.005;                             % final time value
ref = step_tr(timedata,stepdata,ti,tff);
dist = 0;
noise = 0;
pert1 = abv(0,0,0,0,0,0,0,0,0,0);
pert2 = abv(0,0,0,0,0);
pert = abv(pert1,pert2);
u = abv(pert,ref,dist,noise);
y = trsp(clp,u,tff,ti);
yr = sel(y,16,1);
ur = sel(y,17,1);
ym = mscl(yr,1/r);                    
err  = msub(ref,yr);                    % PES in volts
errm = mscl(err,1/r);                   % PES in tracks
% figure(1)
figure
vplot(errm,'c-')
grid
title('Closed-loop transient response')
xlabel('Time (secs)')
ylabel('Position Error Signal (tracks)')
disp(['overshoot: ' num2str(100*(pkvnorm(ym)-1)) '%'])
% figure(2)
figure
vplot(ur,'r-')
grid
title('Control action, due to reference')
xlabel('Time (secs)')
ylabel('u (V)')
disp(['u_max: ' num2str(pkvnorm(ur)) 'V'])
%
% response to the disturbance
ref = 0;
timedata = 0;
stepdata = 0.0005;                      % Td = 0.0005 N.m
ti = 0.000001;                          % time increment
tff = 0.005;                             % final time value
dist = step_tr(timedata,stepdata,ti,tff);
noise = 0;
pert1 = abv(0,0,0,0,0,0,0,0,0,0);
pert2 = abv(0,0,0,0,0);
pert = abv(pert1,pert2);
u = abv(pert,ref,dist,noise);
y = trsp(clp,u,tff,ti);
yd = sel(y,16,1);
ud = sel(y,17,1);
ym = mscl(yd,1/r);                    
err  = msub(ref,yd);                    % PES in volts
errm = mscl(err,1/r);                   % PES in tracks
% figure(3)
figure
vplot(errm,'c-')
grid
title('Transient response to disturbance')
xlabel('Time (secs)')
ylabel('Position Error Signal (tracks)')
disp(['dist. error: ' num2str(100*(pkvnorm(ym))) '%'])
% figure(4)
figure
vplot(ud,'r-')
grid
title('Control action due to disturbance')
xlabel('Time (secs)')
ylabel('u (V)')
%
% response to noise
ti = 0.000001;                          % time increment
tff = 0.005;                             % final time value
pert1 = abv(0,0,0,0,0,0,0,0,0,0);
pert2 = abv(0,0,0,0,0);
pert = abv(pert1,pert2);
ref = 0;
dist = 0;
rand('state',0)
time = [5*ti:5*ti:tff];
noise = siggen('2*(rand-0.5)',time);
u = abv(pert,ref,dist,noise);
y = trsp(clp,u,tff,5*ti);
yn = sel(y,16,1);
un = sel(y,17,1);
ym = mscl(yn,1/r);                    
err  = msub(ref,yn);                    % PES in volts
errm = mscl(err,1/r);                   % PES in tracks
% figure(5)
figure
vplot(errm,'c-')
grid
title('Transient response to noise')
xlabel('Time (secs)')
ylabel('Position Error Signal (tracks)')
disp(['noise error: ' num2str(100*(pkvnorm(ym))) '%'])
% figure(6)
figure
vplot(un,'r-')
grid
title('Control action due to noise')
xlabel('Time (secs)')
ylabel('u (V)')