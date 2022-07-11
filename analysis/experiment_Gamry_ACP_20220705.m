%% experiment_Gamry_ACP_20220705
% Testing to see if the new double chamber inserts remain electrochemically
% insulated across 2 weeks. Comparing to commercial transell inserts. All
% are superglued to the bottom of a 12 well plate. 
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
[gamryStructure_res] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220705_ACP\Resistors');
[gamryStructure_caps] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220705_ACP\Capacitors');

%% Capacitors
%%% Generate error lines %%%
[~, numCaps] = size(gamryStructure_caps);
cap_values = [ 100e-12;
               100e-06;
                10e-12;
                10e-06;
                20e-12;
                20e-12;
               470e-12 ];
for ii = 1:numCaps
    x = gamryStructure_caps(ii).f;
    C = cap_values(ii);
    yZ = 1./(2*pi*C*x);
    cImp_low_10{ii} = (yZ').*0.9;
    cImp_high_10{ii} = (yZ').*1.1;
    cImp_low_1{ii} = (yZ').*0.99;
    cImp_high_1{ii} = (yZ').*1.01;
end

% colorArray = lines(numRuns);
for ii = 1:numCaps
    figure(100+ii)
    x = gamryStructure_caps(ii).f;
    y = gamryStructure_caps(ii).Zmag;
    scatter( x, y, '.')
    hold on
    plot(x, cImp_low_10{ii}, 'r')
    plot(x, cImp_high_10{ii}, 'r')
    plot(x, cImp_low_1{ii}, 'g')
    plot(x, cImp_high_1{ii}, 'g')
    set(gca, 'YScale', 'log')
    set(gca, 'XScale', 'log')
    xlabel('Frequency (Hz)')
    ylabel('mag(Impedance) (Ohm)')
    str = gamryStructure_caps(ii).fname;
    title(str)
end

% Phase
for ii = 1:numCaps
    figure(200+ii)
    x = gamryStructure_caps(ii).f;
    y = gamryStructure_caps(ii).Phase;
    scatter( x, y, '.')
    hold on
    phase_low_10 = y./y .* -80;
    phase_high_10 = y./y .* -100;
    phase_low_1 = y./y .* -88;
    phase_high_1 = y./y .* -92;
    plot(x, phase_low_10, 'r')
    plot(x, phase_high_10, 'r')
    plot(x, phase_low_1, 'g')
    plot(x, phase_high_1, 'g')
    set(gca, 'XScale', 'log')
    xlabel('Frequency (Hz)')
    ylabel('Phase')
    str = gamryStructure_caps(ii).fname;
    title(str)
end

%% Resistors
%%% Generate error lines %%%
[~, numRes] = size(gamryStructure_res);
res_values = [ 100e3;
                10e3;
                 1e3;
                 2e9;
                 5e9;
               976e3 ];

for ii = 1:numRes
    figure(300+ii)
    x = gamryStructure_res(ii).f;
    y = gamryStructure_res(ii).Zmag;
    scatter( x, y, '.')
    hold on
    Zy = (x./x) .* res_values(ii);
    plot(x, Zy.*0.9, 'r')
    plot(x, Zy.*1.1, 'r')
    plot(x, Zy.*0.99, 'g')
    plot(x, Zy.*1.01, 'g')
    set(gca, 'YScale', 'log')
    set(gca, 'XScale', 'log')
    xlabel('Frequency (Hz)')
    ylabel('mag(Impedance) (Ohm)')
    str = gamryStructure_res(ii).fname;
    title(str)
end

% Phase
for ii = 1:numRes
    figure(400+ii)
    x = gamryStructure_res(ii).f;
    y = gamryStructure_res(ii).Phase;
    scatter( x, y, '.')
    hold on
    phase_low_10 = y./y .* -10;
    phase_high_10 = y./y .* 10;
    phase_low_1 = y./y .* -2;
    phase_high_1 = y./y .* 2;
    plot(x, phase_low_10, 'r')
    plot(x, phase_high_10, 'r')
    plot(x, phase_low_1, 'g')
    plot(x, phase_high_1, 'g')
    set(gca, 'XScale', 'log')
    xlabel('Frequency (Hz)')
    ylabel('Phase')
    str = gamryStructure_res(ii).fname;
    title(str)
end