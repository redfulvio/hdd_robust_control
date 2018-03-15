% dk_hdd
%
%  This script file contains the USER DEFINED VARIABLES for the
%	mutools DKIT script file. The user MUST define the 5 variables
%	below.
%
%----------------------------------------------%
% 	REQUIRED USER DEFINED VARIABLES            %
%----------------------------------------------%
% Nominal plant interconnection structure
NOMINAL_DK = sel(sys_ic,[13:18],[13:19]);

% Number of measurements
NMEAS_DK = 1;

% Number of control inputs
NCONT_DK = 1;

% Block structure for mu calculation
BLK_DK = [-1 1;-1 1;-1 1;3 2];

% Frequency response range
OMEGA_DK = logspace(1,5,30);

AUTOINFO_DK = [1 6 1 4*ones(1,size(BLK_DK,1))];

GMAX_DK = 200000;

NAME_DK = 'hdd';
%-------------------- end of dk_hdd --------------------%