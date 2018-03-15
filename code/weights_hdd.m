
function [Wp,Wu,Wn,Wm] = weights_hdd(k)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Perfomance weighting function %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % gain
    gain = 10^-4;

    % Wp1
    if k == 1
        nuWp1 = [1 8*(10^4) 10^8];
        dnWp1 = [1 7*(10^4) 2.5*(10^4)];
        myWp1 = nd2sys(nuWp1,dnWp1,gain);
        Wp = myWp1;
    end

    % Wp2
    if k == 2
        nuWp2 = [1 4*(10^5) 2.5*(10^9)];
        dnWp2 = [1 3.9*(10^5) 6.25*(10^5)];
        myWp2 = nd2sys(nuWp2,dnWp2,gain);
        Wp = myWp2;
    end

    % Wp3
    if k == 3
        nuWp3 = [1 1.15*(10^6) 3.6*(10^10)];
        dnWp3 = [1 1.05*(10^6) 9*(10^6)];
        myWp3 = nd2sys(nuWp3,dnWp3,gain);
        Wp = myWp3;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Control weighting function %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % gain
    gain = 10^-6;

    % Wu1
    if k == 1
        nuWu1 = [0.385 1 1];
        dnWu1 = [10^-4 2*(10^-3) 1];
        myWu1 = nd2sys(nuWu1,dnWu1,gain);
        Wu = myWu1;
    end
    % Wu2
    if k == 2
        nuWu2 = [0.55 1 1];
        dnWu2 = [10^-4 2.1*(10^-3) 1];
        myWu2 = nd2sys(nuWu2,dnWu2,gain);
        Wu = myWu2;
    end
    % Wu3
    if k == 3
        nuWu3 = [4.05 1 1];
        dnWu3 = [10^-4 2*(10^-3) 1];
        myWu3 = nd2sys(nuWu3,dnWu3,3*gain);
        Wu = myWu3;
    end
    
    %%%%%%%%%%%%%%%%
    % Sensor noise %
    %%%%%%%%%%%%%%%%
    nuWn = [0.1    1];
    dnWn = [0.001  1];
    gainWn = 0.0006;
    Wn = nd2sys(nuWn,dnWn,gainWn);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Model transfer function %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    nuWm = 1;
    dnWm = [0.00000000375 0.00012 1]; 
    gainWm = 1;
    Wm = nd2sys(nuWm,dnWm,gainWm);
    
end