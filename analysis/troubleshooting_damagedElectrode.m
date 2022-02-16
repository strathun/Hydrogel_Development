%% troubleshooting_damagedElectrode
% Something happened with the electrodes on 20220213. Trying to figure out
% which electrode was damaged and get it fixed. 

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
% Names should be good to go. Just uncomment here and below to add in each
% day.
[gamryStructure_EIS_cell_Day01] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220212_WPI02_GellCell_Day01');
[gamryStructure_EIS_cell_Day02] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220213_WPI02_GellCell_Day02');
[gamryStructure_EIS_troubleshooting] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220214_ElectrodeTroubleshooting');
[gamryStructure_EIS_cell_DayXX] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220123_WPI02_GelCell_Day05');

%% Plot Averages

% CELL Day 1% 
meanArray = [];
PhaseArray = [];
meanMeanArray = [];
stdMeanArray = [];
meanPhaseArray = [];
stdPhaseArray = [];


pointerArray = [1]; 
numMeasures = length(pointerArray);
for ii = 1:numMeasures
    jj = pointerArray(ii);
    yyaxis left
    loglog( gamryStructure_EIS_cell_DayXX(jj).f, ...
            gamryStructure_EIS_cell_DayXX(jj).Zmag )
    hold on
    yyaxis right
    loglog( gamryStructure_EIS_cell_Day01(jj).f, ...
            gamryStructure_EIS_cell_Day01(jj).Phase )
end

pointerArray = [1 2]; 
numMeasures = length(pointerArray);
for ii = 1:numMeasures
    jj = pointerArray(ii);
    yyaxis left
    loglog( gamryStructure_EIS_cell_Day01(jj).f, ...
            gamryStructure_EIS_cell_Day01(jj).Zmag )
    hold on
    yyaxis right
    loglog( gamryStructure_EIS_cell_Day01(jj).f, ...
            gamryStructure_EIS_cell_Day01(jj).Phase )
end

pointerArray = [1 2]; 
numMeasures = length(pointerArray);
for ii = 1:numMeasures
    jj = pointerArray(ii);
    yyaxis left
    loglog( gamryStructure_EIS_cell_Day02(jj).f, ...
            gamryStructure_EIS_cell_Day02(jj).Zmag )
    hold on
    yyaxis right
    loglog( gamryStructure_EIS_cell_Day02(jj).f, ...
            gamryStructure_EIS_cell_Day02(jj).Phase )
end

pointerArray = [4 9]; 
numMeasures = length(pointerArray);
for ii = 1:numMeasures
    jj = pointerArray(ii);
    yyaxis left
    loglog( gamryStructure_EIS_troubleshooting(jj).f, ...
            gamryStructure_EIS_troubleshooting(jj).Zmag )
    hold on
    yyaxis right
    loglog( gamryStructure_EIS_troubleshooting(jj).f, ...
            gamryStructure_EIS_troubleshooting(jj).Phase )
end

legend('Previous Exp', 'Day 1 -r1', 'Day 1 - r2', 'Working', 'Broken', 'Test', 'Test 2')

