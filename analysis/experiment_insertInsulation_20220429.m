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
% 
[gamryStructure_EIS_cell_Day01] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220429_WPI03_Insert_insulation');


%% Individual Measurement Plots
% Day 01 %
figure
yyaxis left
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

% 
% r01, r06, and r07 look to be a parallel RC circuit: The impedance is flat
% at higher lower frequencies where the impedance through the parallel cap
% is high enough to force most current through the resistor and we see a
% mostly flat impedance (resistance). I belive this can be thought of as 
% the impedance, or resistance of the well. Then we see a clear
% [pole?/corner?] as the capacitance opens up and the impedance decreases
% linearly with increasing frequency. The phase matches this circuit
% topology as well as we see a clear transition from 0degree phase shift
% (resistor) to 90degree (capacitor). This matches well with the Gamry
% application note that says the stray capacitance of the system can be
% modeled as a capacitor in parallel with the electrochemical cell. Now, we
% know that the whole electrochemical cell can't necessarily be modeled as
% a single resistor so, if we put a simple randles model in with the
% parallel capacitor for the system stray capacitance we also get a very
% good fit and the estimated capacitance of the parallel capacitor is quite
% close to the estimated value for the system's stray capacitance. In
% truth, we should use a slightly more complicated model to pull out the
% values of the well. To do this, we should fit a culture media measurement
% to fit the values for the electrode/solution and then add in a parallel
% RC impedance in series with this electrode model with values of the stray
% capacitance and the electrode fixed, then we can estimate values for the
% insert!