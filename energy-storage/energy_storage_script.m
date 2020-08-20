clearvars;


%% Grid parameters
grid.fn = 60;
grid.UB1 = 690;   % Line voltage
grid.UB2 = 11e3;

%% Simulation parameters
sim.tStep = 1/(grid.fn*1e3);
sim.tTotal = 1;


%% VSC parameters

% Design parameters
vsc.fSwitch = grid.fn*100;  % VSC switch frequency 
vsc.maxDeltaI = 0.25;       % Max current ripple % on the converter side inductance
vsc.Dlc = 0.33;             % Damping factor of the LCL filter (recommended = 0.33)
vsc.maxDeltaVdc = 0.05;     % Max voltage ripple % on the dc-link
vsc.maxDeltaP = 0.1025;     % Max power to be supplied by dc-link
vsc.maxDeltaT = 1/grid.fn;  % Max time to supply DeltaP (recommended = 1 grid cycle) 
vsc.kFilter = 0.5;          % factor for measurement cut-off frequency (recommended < 0.5)
vsc.mmax = 0.5;             % 0.5 for sinusoidal PWM; 0.5774 for third harmonic injection


% Base values
vsc.fbase = grid.fn;
vsc.Sbase = 1.1e6;
vsc.Vbase = grid.UB1;  % Phase voltage
vsc.Vdcbase = 1500;    % DC-link voltage

[designOk, vsc.filter, vsc.filterpu, vsc.ctrl] = VSCdesignpu(vsc);

% PLL
vsc.pll.Kp = 120;
vsc.pll.Ki = 50;
vsc.pll.Kd = 30;
vsc.pll.Tr = 100;

% Active power control
vsc.Pdroop.Kp = 10;
vsc.Pdroop.Kd = 0;
vsc.Pdroop.Tr = 100;
vsc.Pdroop.flp = 0.5 * vsc.ctrl.ffilt;
vsc.Pdroop.DB = 0.001;


% Reactive power control
vsc.Qdroop.Kp = 0;
vsc.Qdroop.Kd = 0;
vsc.Qdroop.Tr = 100;
vsc.Qdroop.flp = 0.5 * vsc.ctrl.ffilt;
vsc.Qdroop.DB = 0.002;