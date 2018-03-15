% Generate the open-loop connection for the
% system simulation
%
mod_hdd
systemnames = ' G Wn ';
inputvar = '[ pert{15}; ref; dist; noise; control ]';
outputvar = '[ G(1:15); G(16); control; ref-G(16)-Wn ]';
input_to_G = '[ pert; dist; control ]';
input_to_Wn = '[ noise ]';
sysoutname = 'sim_ic';
cleanupsysic = 'yes';
sysic

