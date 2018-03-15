%   FILES FOR ANALYSIS AND DESIGN OF HARD DISK DRIVE SERVO SYSTEM
%
%
% Construction of the open-loop system
%
% olp_hdd.m	   Creates the model of the uncertain open loop system
%
% Controllers design
%
% hinf_hdd.m   Design of Hinf controller
% ms_hdd.m	   Design of mu-controller
% pid_hdd.m	   Design of pid-controller
% lqg_hdd.m	   Design of LQG-controller
%
% Analysis of the continuous time closed loop system
%
% mu_hdd.m	   Analysis of robust stability, nominal and robust performance
% frs_hdd.m	   Frequency responses of the closed loop system
% clp_hdd.m	   Transient responses of the closed loop system
%
% Comparison of the systems with three controllers
%
% kf_hdd.m	   Frequency responses of the three controllers
% cfr_hdd.m	   Frequency responses of the three closed loop systems
% ctr_hdd.m	   Transient responses of the three closed loop systems
% prf_hdd.m	   Nominal performance of the three closed loop systems
% rbs_hdd.m	   Robust stability of the three closed loop systems
% rbp_hdd.m	   Robust performance of the three closed loop systems
%
% Auxiliary files
%
% mod_hdd.m        Creates the uncertainty system model
% weights_hdd.m	   Sets the weighting  functions
% dk_hdd.m         Sets the DK-iterations parameters in the mu-synthesis
% gui_hdd.m        Run the GUI
% sim_hdd.m        Creates the simulation model of the closed loop system