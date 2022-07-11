%% experiment_insertInsulation_20220427
% Testing to see if the new double chamber inserts are electrochemically
% insulated
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
    extractImpedanceDataGlobal('..\rawData\Gamry\20220427_WPI03_Insert_insulation\closed_circuit');


%% Individual Measurement Plots
% Day 01 %
figure
yyaxis left
% plot_order = [2 3 4 5 7 8 9 10 12 13 14 15];
[~, numRuns] = size(gamryStructure_EIS_cell_Day01);
for ii = 1:numRuns
    s = gamryStructure_EIS_cell_Day01(ii).fname;
    [display_name(ii), ~] = regexp(s, 'r[0-9][0-9]','match','split');
    loglog( gamryStructure_EIS_cell_Day01(ii).f, ...
            gamryStructure_EIS_cell_Day01(ii).Zmag)
    hold on
end
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')

yyaxis right
for ii = 1:numRuns
    loglog( gamryStructure_EIS_cell_Day01(ii).f, ...
            gamryStructure_EIS_cell_Day01(ii).Phase )
    hold on
end
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')
xlim([9.9 1e6])
legend(string(display_name))
% title('Day 02 - Individual Measurements')