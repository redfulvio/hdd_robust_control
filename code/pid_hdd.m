% PID controller

% PIDF =
%  
%              1            s    
%   Kp + Ki * --- + Kd * --------
%              s          Tf*s+1 
% 
%   with Kp = 0.0132, Ki = 0.734, Kd = 8.69e-06, Tf = 1.45e-05
%  
% Continuous-time PIDF controller in parallel form.


% values calculated by pidTuner
kp = 0.0132;
kd = 0.734;
ki = 8.69e-06;
Tf = 1.45e-05;

% compute PID
KPID = pid(kp,kd,ki,Tf); 

% package PID
[numK,denK] = tfdata(KPID);
[AK,BK,CK,DK] = tf2ss(numK{1,1},denK{1,1});
K_pid = pck(AK,BK,CK,DK);
K = K_pid;