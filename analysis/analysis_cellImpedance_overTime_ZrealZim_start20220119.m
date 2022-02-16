%% analysis_cellImpedance_overTime_ZrealZim_start20220119
% Looking for changes in impedance across XX days as we try to grow a
% monolayer of astrocytes on 4 gels. Compared to a control well with just
% the culture media used with the astrocytes. This control is measured
% first and last to get an idea of any electrode drift that might be
% happening.

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
    extractImpedanceDataGlobal('..\rawData\Gamry\20220212_WPI02_GelCell_Day01');
[gamryStructure_EIS_cell_Day02] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220213_WPI02_GelCell_Day02');
[gamryStructure_EIS_cell_Day03] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220214_WPI02_GelCell_Day03');
[gamryStructure_EIS_cell_Day04] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220215_WPI02_GelCell_Day04');
[gamryStructure_EIS_cell_Day05] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220216_WPI02_GelCell_Day05\EIS');
% [gamryStructure_EIS_cell_Day05] = ...
%     extractImpedanceDataGlobal('..\rawData\Gamry\20220123_WPI02_GelCell_Day05');

%%
allImpMeanArray = [];
allImpStdArray = [];

% CELL Day 5 % 
figure
meanArray = [];
PhaseArray = [];
RealArray = [];
ImArray = [];
meanMeanArray = [];
stdMeanArray = [];
meanPhaseArray = [];
stdPhaseArray = [];

% 01/21
pointerArray = [3 4 5 6 7 8]; 
numMeasures = length(pointerArray);
for ii = 1:numMeasures
    jj = pointerArray(ii);
    meanArray = [meanArray gamryStructure_EIS_cell_Day05(jj).Zmag];
    RealArray = [RealArray gamryStructure_EIS_cell_Day05(jj).Zreal];
    ImArray = [ImArray gamryStructure_EIS_cell_Day05(jj).Zim];
    PhaseArray = [PhaseArray gamryStructure_EIS_cell_Day05(jj).Phase];
end

meanMeanArray = mean(meanArray, 2);
stdMeanArray = std(meanArray, 0, 2);
meanPhaseArray = mean(PhaseArray, 2);
stdPhaseArray = std(PhaseArray, 0, 2);

allImpMeanArray = [allImpMeanArray mean(RealArray, 2)];
allImpStdArray = [allImpStdArray std(RealArray, 0, 2)];
allImpMeanArray = [allImpMeanArray mean(ImArray, 2)];
allImpStdArray = [allImpStdArray std(ImArray, 0, 2)];

yyaxis left
errorbar( gamryStructure_EIS_cell_Day05(1).f, ...
        meanMeanArray, ...
        stdMeanArray, 'LineWidth', 2.0)
hold on
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')

yyaxis right
errorbar( gamryStructure_EIS_cell_Day05(1).f, ...
        meanPhaseArray, ...
        stdPhaseArray, 'LineWidth', 2.0)
hold on
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')


% CULTURE MEDIA % 
meanArray = [];
PhaseArray = [];
meanMeanArray = [];
stdMeanArray = [];
meanPhaseArray = [];
stdPhaseArray = [];
RealArray = [];
ImArray = [];

% 01/21
pointerArray = [1 2]; 
numMeasures = length(pointerArray);
for ii = 1:numMeasures
    jj = pointerArray(ii);
    meanArray = [meanArray gamryStructure_EIS_cell_Day05(jj).Zmag];
    RealArray = [RealArray gamryStructure_EIS_cell_Day05(jj).Zreal];
    ImArray = [ImArray gamryStructure_EIS_cell_Day05(jj).Zim];
    PhaseArray = [PhaseArray gamryStructure_EIS_cell_Day05(jj).Phase];
end

meanMeanArray = mean(meanArray, 2);
stdMeanArray = std(meanArray, 0, 2);
meanPhaseArray = mean(PhaseArray, 2);
stdPhaseArray = std(PhaseArray, 0, 2);

allImpMeanArray = [allImpMeanArray mean(RealArray, 2)];
allImpStdArray = [allImpStdArray std(RealArray, 0, 2)];
allImpMeanArray = [allImpMeanArray mean(ImArray, 2)];
allImpStdArray = [allImpStdArray std(ImArray, 0, 2)];

yyaxis left
errorbar( gamryStructure_EIS_cell_Day01(1).f, ...
        meanMeanArray, ...
        stdMeanArray, 'LineWidth', 1.0)
hold on
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
xlim([10 1e6])

yyaxis right
errorbar( gamryStructure_EIS_cell_Day01(1).f, ...
        meanPhaseArray, ...
        stdPhaseArray, 'LineWidth', 1.0)
hold on
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')
xlim([9.9 1e6])
legend('Gels', 'CM')
   
%% Plot Zim and Zreal
% ZReal %
figure
errorbar( gamryStructure_EIS_cell_Day01(1).f, ...
        allImpMeanArray(:,1), ...
        allImpStdArray(:,1), 'LineWidth', 1.0)
hold on
errorbar( gamryStructure_EIS_cell_Day01(1).f, ...
        allImpMeanArray(:,3), ...
        allImpStdArray(:,3), 'LineWidth', 1.0)
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
xlim([10 1e6])
legend('Gels', 'CM')
title('Day 05')

% ZIm % 
figure
errorbar( gamryStructure_EIS_cell_Day01(1).f, ...
        -1*allImpMeanArray(:,2), ...
        allImpStdArray(:,2), 'LineWidth', 1.0)
hold on
errorbar( gamryStructure_EIS_cell_Day01(1).f, ...
        -1*allImpMeanArray(:,4), ...
        allImpStdArray(:,4), 'LineWidth', 1.0)
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
xlim([10 1e6])
legend('Gels', 'CM')
title('Day 05')