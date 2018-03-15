% LFT Model of the Hard Disk Drive Servo System
%
J = 6.3857*10^(-6);     % kg.m^2     Arm moment of inertia  
R = 5.08*10^(-2);       % m          Arm length
Kpa = 10;               % V/V        Amplifier gain
Kt = 9.183*10^(-2);     % N.m/A      VCM torque constant
Kb = 9.183*10^(-2);     % V.s/rad    Back EMF constant
tpm = 10^6;             % tracks/m   Tracks per meter
Ky = 1.2;               % V/track    Position measurement gain
Rcoil = 8;              % Om         Coil resistance
Rs = 0.2;               % Om         Sense resistance
Lcoil = 0.001;          % H          Coil inductance
Rc = Rcoil + Rs;        % Om
%
w1 = 2*pi*50;    z1 = 0.3;    b1 =  0.006;    b2 =  0;         % f1 =   50 Hz
w2 = 2*pi*2200;  z2 = 0.024;  b3 =  0.013;    b4 = -0.0018;    % f2 = 2200 Hz  
w3 = 2*pi*6400;  z3 = 0.129;  b5 =  0.723;    b6 = -0.0015;    % f3 = 6400 Hz 
w4 = 2*pi*8800;  z4 = 0.173;  b7 =  0.235;    b8 = -0.0263;    % f4 = 8800 Hz  
%
pw1 = 0.05;  pz1 = 0.05;  
pw2 = 0.12;  pz2 = 0.08;  
pw3 = 0.08;  pz3 = 0.10; 
pw4 = 0.15;  pz4 = 0.10;  
pkt = 0.10;  pj  = 0.10;   pky = 0.05;  
%
% Voice Coil Admittance
tau = Lcoil/Rc;
num_vca = 1;
den_vca = [tau  1];
gain_vca = 1/Rc;
Gvca = nd2sys(num_vca,den_vca,gain_vca);
%
% Resonances
% Mode 1
A = [ 0     w1
     -w1 -2*w1*z1 ];
B1 = [ 0   pw1     0
      pw1   0  -2*w1*pz1 ];
B2 = [ 0
       w1];
C1 = [-w1  -2*w1*z1
       0      w1
       0      z1   ];
C2 = [ b1  b2];
D11 = [ 0   0  -2*w1*pz1
        0   0      0
        0   0      0    ];
D12 = [ w1
        0
        0 ];
D21 = [ 0  0  0 ];
D22 = 0;
G1 = pck(A,[B1 B2],[C1;C2],[D11 D12;D21 D22]);
%
% Mode 2
A = [ 0     w2
     -w2 -2*w2*z2 ];
B1 = [ 0   pw2     0
      pw2   0  -2*w2*pz2 ];
B2 = [ 0
       w2 ];
C1 = [-w2  -2*w2*z2
       0      w2
       0      z2   ];
C2 = [ b3  b4 ];
D11 = [ 0   0  -2*w2*pz2
        0   0      0
        0   0      0    ];
D12 = [ w2
        0
        0 ];
D21 = [ 0  0  0 ];
D22 = 0;
G2 = pck(A,[B1 B2],[C1;C2],[D11 D12;D21 D22]);
%
% Mode 3
A = [ 0     w3
     -w3 -2*w3*z3 ];
B1 = [ 0   pw3     0
      pw3   0  -2*w3*pz3 ];
B2 = [ 0
       w3 ];
C1 = [-w3  -2*w3*z3
       0      w3
       0      z3   ];
C2 = [ b5  b6 ];
D11 = [ 0   0  -2*w3*pz3
        0   0      0
        0   0      0    ];
D12 = [ w3
        0
        0 ];
D21 = [ 0  0  0 ];
D22 = 0;
G3 = pck(A,[B1 B2],[C1;C2],[D11 D12;D21 D22]);
%
% Mode 4
A = [ 0     w4
     -w4 -2*w4*z4 ];
B1 = [ 0   pw4     0
      pw4   0  -2*w4*pz4 ];
B2 = [ 0
       w4 ];
C1 = [-w4  -2*w4*z4
       0      w4
       0      z4   ];
C2 = [ b7  b8 ];
D11 = [ 0   0  -2*w4*pz4
        0   0      0
        0   0      0    ];
D12 = [ w4
        0
        0 ];
D21 = [ 0  0  0 ];
D22 = 0;
G4 = pck(A,[B1 B2],[C1;C2],[D11 D12;D21 D22]);
%
% Rigid-body
mat_kt = [ 0    Kt
           pkt  Kt ];
mat_j  = [ -pj  1/J
           -pj  1/J ]; 
mat_ky = [ 0    Ky
           pky  Ky ];
int1 = nd2sys([0 1],[1 0],1);
int2 = nd2sys([0 1],[1 0],R*tpm);
%
% model connection
systemnames = ' Kpa Kb Rs Gvca G1 G2 G3 G4 mat_kt mat_j mat_ky int1 int2 ';
inputvar = '[ pert{15}; dist; control ]';
outputvar = '[ G1(1:3); G2(1:3); G3(1:3); G4(1:3); mat_kt(1); mat_j(1); mat_ky(1:2) ]';
input_to_Kpa = '[ control-Rs ]';
input_to_Kb = '[ int1 ]'; 
input_to_Gvca = '[ Kpa-Kb ]';
input_to_Rs = '[ Gvca ]';
input_to_mat_kt = '[ pert(13); Gvca ]';
input_to_G1 = '[ pert(1:3);   mat_kt(2)+dist ]';
input_to_G2 = '[ pert(4:6);   mat_kt(2)+dist ]';
input_to_G3 = '[ pert(7:9);   mat_kt(2)+dist ]';
input_to_G4 = '[ pert(10:12); mat_kt(2)+dist ]';
input_to_mat_j = '[ pert(14); G1(4)+G2(4)+G3(4)+G4(4) ]';
input_to_int1 = '[ mat_j(2) ]';
input_to_int2 = '[ int1 ]';
input_to_mat_ky = '[ pert(15); int2 ]'; 
sysoutname = 'G';
cleanupsysic = 'yes';
sysic
