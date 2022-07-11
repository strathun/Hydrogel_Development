%% experiment_insertInsulationTest_20220411
% Wanted to try to see if the insers were still electrochemically
% insulated despite having multiple connection points between the multiple
% pieces. This script is looking to see if maybe the 3e setup is inherently
% flawed for measuring his type of stuff. By having the reference electrode
% next to the WE, we may just always be measuring he difference between
% these two (which shouldn't change with a different membrane) instead of
% the membrane itself. 

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
[gamryStructure_EIS] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220411_WPI02_Insert_insulation\closed_circuit');

%% Current
figure
for ii = 1:5
    loglog( gamryStructure_EIS(ii).f, ...
            gamryStructure_EIS(ii).Idc)
    hold on
end
xlabel('Frequency (Hz)')
ylabel('Current')
legend('r01', 'r04', 'r06', 'r07', 'r08')

%% Impedance
figure
for ii = 1:5
    loglog( gamryStructure_EIS(ii).f, ...
            gamryStructure_EIS(ii).Zmag)
    hold on
end
xlabel('Frequency (Hz)')
ylabel('Current')
legend('r01', 'r04', 'r06', 'r07', 'r08')
