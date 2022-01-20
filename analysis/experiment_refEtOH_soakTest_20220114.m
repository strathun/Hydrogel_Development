%% experiment_refEtOH_soakTest_20220114
% Wanted to check to see if soaking the AgAgCl chamber reference electrode 
% in EtOH causes any damage, as indicated by changes in the measured
% impedance. Will need to do some sort of sterilization for the cell
% impedance measurements. Electrode was soaked for 15 seconds and then
% rinsed.

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
[gamryStructure_EIS_gel] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220114_WPI02_InVitro_CM');

%% Impedance and phase 
% Calculate means/std
[~, numMeasures] = size(gamryStructure_EIS_gel);
meanArray = [];
PhaseArray = [];
jj = 1;
for ii = 1:numMeasures
    meanArray = [meanArray gamryStructure_EIS_gel(ii).Zmag];
    PhaseArray = [PhaseArray gamryStructure_EIS_gel(ii).Phase];
    if mod(ii,3) == 0
        meanMeanArray(:,jj) = mean(meanArray, 2);
        stdMeanArray(:,jj) = std(meanArray, 0, 2);
        meanPhaseArray(:,jj) = mean(PhaseArray, 2);
        stdPhaseArray(:,jj) = std(PhaseArray, 0, 2);
        jj = jj + 1;
        meanArray = [];
        PhaseArray = [];
    end
end

%% Plot
figure
for ii = 1:4
    yyaxis left
    errorbar( gamryStructure_EIS_gel(1).f, ...
            meanMeanArray(:,ii), ...
            stdMeanArray(:,ii))
    hold on
end
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
xlim([10 1e5])

for ii = 1:4
    yyaxis right
    errorbar( gamryStructure_EIS_gel(1).f, ...
            meanPhaseArray(:,ii), ...
            stdPhaseArray(:,ii))
    hold on
end
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
xlim([10 1e5])
legend('Baseline', 'Ctrl Rinse 1', 'EtOH Soak', 'Ctrl Rinse 2')

%%
% Almost no difference. Apparent drift in impedance has a bigger effect
% than EtOH. 