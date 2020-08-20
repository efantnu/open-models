clearvars;


%% VSC parameters

% Base values
vsc.fbase = 60;
vsc.Sbase = 9.75e6;
vsc.Vbase = 818;      % Line voltage
vsc.Vdcbase = 771;    % DC-link voltage

% Design parameters
vsc.fSwitch = vsc.fbase*70;  % VSC switch frequency 
vsc.maxDeltaI = 0.15;        % Max current ripple % on the converter side inductance
vsc.Qlc = 0.3;             % Quality factor of the LCL filter (recommended = 3)
vsc.maxDeltaVdc = 96/vsc.Vdcbase;   % Max voltage ripple % on the dc-link
vsc.maxDeltaP = 143.9e3 / vsc.Sbase;     % Max power to be supplied by dc-link
vsc.maxDeltaT = 0.5/vsc.fbase;  % Max time to supply DeltaP (recommended = 1 grid cycle) 
vsc.kFilter = 0.5;          % factor for measurement cut-off frequency (recommended < 0.5)
vsc.mmax = 0.5;             % 0.5 for sinusoidal PWM; 0.5774 for third harmonic injection

[designOk, vsc.filter, vsc.filterpu, vsc.ctrl] = VSCdesignpu(vsc);
