%% experiment_validateCapDeEmbedMethod
% Making sure that putting the 33pF cap in parallel is a valid technique.
% Comparing measurements made using a 10pF cap with our Gamry which should
% be beyond it's ACP limit, to one made with the same system and a 33pF cap
% in parallel, to what should be the TRUE value using the Solzbacher's
% Gamry 600 which has a bigger impedance range. 
close all 
clearvars 

% Sets relative filepaths from this script
currentFile = mfilename( 'fullpath' );
cd(fileparts(currentFile));
addpath(genpath('../matlab'));
addpath(genpath('../rawData'));
addpath(genpath('../output'));
parts = strsplit(currentFile, {'\', '\'});
outputDir = ['../output/' parts{end}];
[~, ~] = mkdir(outputDir);

%% Extract impedance data
% 
[gamryStructure_EIS_Walker] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220708_Troubleshooting');
[gamryStructure_EIS_Solzbacher] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry_Solzbacher\20220708_Troubleshooting');

%% Individual Measurement Plots
%%% Day 00 %%%
% Impedance 
figure

% 10pF_Walker
x = gamryStructure_EIS_Walker(2).f;
y = gamryStructure_EIS_Walker(2).Zmag;
scatter( x, y, '.' )
hold on
% 10pF||33pF_Walker
x = gamryStructure_EIS_Walker(1).f;
y = gamryStructure_EIS_Walker(1).Zmag;
C = 33.71e-12; % Calculated using fit in EChem Analyst (Gamry)
yZ = (y)./(1-(2*pi.*x.*y.*C));
scatter( x, yZ, '.' )
% 10pF_Solzbacher
x = gamryStructure_EIS_Solzbacher(1).f;
y = gamryStructure_EIS_Solzbacher(1).Zmag;
scatter( x, y, '.' )

set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
xlim([9.9 1e6])
legend( '10pF - Walker', '10-33pFParallel - Walker', '10pF - Solzbacher' )
title('Impedance')

% % Phase
figure
% 10pF_Walker
x = gamryStructure_EIS_Walker(2).f;
y = gamryStructure_EIS_Walker(2).Phase;
scatter( x, y, '.' )
hold on
% 10pF||33pF_Walker
x = gamryStructure_EIS_Walker(1).f;
y = gamryStructure_EIS_Walker(1).Phase;
% C = 33.71e-12; % Calculated using fit in EChem Analyst (Gamry)
% yZ = (y)./(1-(2*pi.*x.*y.*C));
scatter( x, y, '.' )
% 10pF_Solzbacher
x = gamryStructure_EIS_Solzbacher(1).f;
y = gamryStructure_EIS_Solzbacher(1).Phase;
scatter( x, y, '.' )

phase_low_1 = y./y .* -88;
phase_high_1 = y./y .* -92;
plot(x, phase_low_1, 'g')
plot(x, phase_high_1, 'g')

set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
ylim([-100 -80])
legend( '10pF - Walker', '10-33pFParallel - Walker', '10pF - Solzbacher' )
title('Phase')
% Looks good! Going to move forward with the parallel cap de-embedding for
% now. If things get hairy explore the other measurements in here. 

%% DeEmbed Phase
% Calculate
phase_calc = atan( -1.* gamryStructure_EIS_Solzbacher(1).Zim ./ ...
                     gamryStructure_EIS_Solzbacher(1).Zreal);
phase_calc = rad2deg( phase_calc );
figure
x = gamryStructure_EIS_Solzbacher(1).f;
y = gamryStructure_EIS_Solzbacher(1).Phase;
scatter( x, y )
hold on
scatter( x, phase_calc, '.' )

% Let's ignore this for now. Rexamine it if we see the prints failing with
% the regular Gamry measurement and it's not shown in the parallel cap
% version (_r02). 