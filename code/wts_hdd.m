% Performance weighting functions for the Hard Disk Drive System
% design
%
% Model transfer function
nuWm = 1;
dnWm = [0.00000000375 0.00012 1]; 
gainWm = 1;
Wm = nd2sys(nuWm,dnWm,gainWm);
%
% Performance weighting function
%nuWp = [1  80000  100000000];          % Version 1
%dnWp = [1  70000  25000    ];
%gainWp = 0.0001; 
%
nuWp = [1  400000  2500000000];        % Version 2 
dnWp = [1  390000  625000    ];
gainWp = 0.0001; 
%
%nuWp = [1  1150000  36000000000];      % Version 3
%dnWp = [1  1050000  9000000   ];
%gainWp = 0.0001; 
Wp = nd2sys(nuWp,dnWp,gainWp);
%
% Control weighting function
%
%nuWu = [0.385   1       1];            % Version 1                 
%dnWu = [0.0001  0.002  1];            
%gainWu = 0.000001;
%
nuWu = [0.55    1       1];            % Version 2                  
dnWu = [0.0001  0.0021  1];            
gainWu = 0.000001;
%
%nuWu = [0.405    1       1];           % Version 3                  
%dnWu = [0.0001  0.002   1];            
%gainWu = 0.000003;
Wu = nd2sys(nuWu,dnWu,gainWu);
%
% Sensor noise
nuWn = [0.1    1];
dnWn = [0.001  1];
gainWn = 0.0006;
Wn = nd2sys(nuWn,dnWn,gainWn);
