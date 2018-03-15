% LQG

mod_hdd
olp_hdd


olp_ic = sel(G,16,17);
[A,B,C,D] = unpck(olp_ic);
Gnom = ss(A,B,C,D);

n = size(A);

% weithing matrices
Q = eye(n) * 1000;
R = 1;

Qn = eye(n) * 10000;
Rn = 1;

QXU = blkdiag(Q,R);
QWV = blkdiag(Qn,Rn);

% compute LQG
KLQG = lqg(Gnom,QXU,QWV);

s = tf('s');

KlqgTF = tf(KLQG);
KlqgTF = KlqgTF * (-1);

% package LQG
[numK,denK] = tfdata(KlqgTF);
[AK,BK,CK,DK] = tf2ss(numK{1,1},denK{1,1});
K_lqg = pck(AK,BK,CK,DK);
K = K_lqg;





