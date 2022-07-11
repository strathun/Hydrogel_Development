%% figure_insertInsulation_overTime
%  Presentation of data from
%  'experiment_insertInsulation_overTime_start20220621'
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
% [gamryStructure_EIS_cell_Day01] = ...
%     extractImpedanceDataGlobal('..\rawData\Gamry\20220505_WPI03_Insert_insulation_Day00');
% [gamryStructure_EIS_cell_Day03] = ...
%     extractImpedanceDataGlobal('..\rawData\Gamry\20220512_WPI03_Insert_insulation_Day07');
% [gamryStructure_EIS_cell_Day05] = ...
%     extractImpedanceDataGlobal('..\rawData\Gamry\20220519_WPI03_Insert_insulation_Day14');
% [gamryStructure_EIS_cell_Day06] = ...
%     extractImpedanceDataGlobal('..\rawData\Gamry\20220523_WPI03_Insert_insulation');
% [gamryStructure_EIS_TDT_InVivo] = ...
%     extractImpedanceDataGlobal('..\rawData\Gamry\2018-03-20_TDT5_Day19\Impedance');

% Second example to see if above is within typical in vivo range. 
% [gamryStructure_EIS_TDT_InVivo] = ...
%     extractImpedanceDataGlobal('..\rawData\Gamry\2019-07-30_TDT19_Day11\Impedance');
% [gamryStructure_EIS_Open] = ...
%     extractImpedanceDataGlobal('..\rawData\Gamry\20220428_WPI03_Insert_insulation');
% Round 2
[gamryStructure_EIS_cell_Day01_r2] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220621_WPI03_Insert_insulation_Day00');
[gamryStructure_EIS_cell_Day02_r2] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220623_WPI03_Insert_insulation_Day02');
[gamryStructure_EIS_cell_Day03_r2] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220628_WPI03_Insert_insulation_Day07');
[gamryStructure_EIS_cell_Day04_r2] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220705_WPI03_Insert_insulation_Day14');

%% Impedance + Capacitance Fit
%%% Day 00 %%%
colorArray = lines(2);

% Impedance 
figure
yyaxis left
x = gamryStructure_EIS_cell_Day01_r2(2).f;
y = gamryStructure_EIS_cell_Day01_r2(2).Zmag;
scatter( x(1:31), y(1:31), [], colorArray( 1, : ), 'LineWidth', 1.5)
hold on
% Impedance of a pure capacitor
C = 8.31e-12; % Calculated using fit in EChem Analyst (Gamry)
yZ = 1./(2*pi*C*x);
yZ = yZ';
plot( x(1:31), yZ(1:31), 'Color', colorArray( 1, : ), 'LineWidth', 1.5)

% Figure Settings (right
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
ylabel('mag(Impedance) (Ohm)')
    
% Phase % 
yyaxis right
x = gamryStructure_EIS_cell_Day01_r2(2).f;
y = gamryStructure_EIS_cell_Day01_r2(2).Phase;
scatter( x(1:31), y(1:31), [], colorArray( 2, : ), 'LineWidth', 1.5)
hold on
% Phase of pure capacitor
y = y./y .* -90;
plot( x(1:31), y(1:31), 'Color', colorArray( 2, : ), 'LineWidth', 1.5)

% Figure settings (left)
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')
xlim([1e3 1e6])
ylim([-120 0])
legend('Measured', 'Modeled')

% Here, we're essentially just showing that these walls are basically small
% capacitors, meaning they have relatively high impedance until extremely
% high frequencies. This is both usefull as a characterization of the
% properties of the plastic prints, and to justify the later comparisons of
% the prints over time using fitted values of capacitors.
% In fig. XX we see a sample impedance measurements for one of the printed
% systems. We see that the impedance matches the general shape of an ideal
% capacitor, which has been fit to the data using Gamry's Echem Analyst
% software. Using these, fits we can quantify the insulative properties of
% the walls of the devices using both the impedance spectrum and their
% fitted capacitor equivalents. 
%% Avg Impedance Change
colorArray = lines(2);

%%% Day 00 %%%
for ii = 1:3
    imp_array_day00(:,ii) = gamryStructure_EIS_cell_Day01_r2(ii).Zmag;
end
mean_imp_day00 = mean(imp_array_day00,2);
std_imp_day00  = std(imp_array_day00, 0, 2);

%%% Day 07 %%%
for ii = 2:4
    imp_array_day07(:,ii-1) = gamryStructure_EIS_cell_Day03_r2(ii).Zmag;
end
mean_imp_day07 = mean(imp_array_day07,2);
std_imp_day07  = std(imp_array_day07, 0, 2);

%%% Day 14 %%%
for ii = 3:4    % print 04 failed
    imp_array_day14(:,ii-2) = gamryStructure_EIS_cell_Day03_r2(ii).Zmag;
end
mean_imp_day14 = mean(imp_array_day14,2);
std_imp_day14  = std(imp_array_day14, 0, 2);

figure
errorbar( gamryStructure_EIS_cell_Day01_r2(1).f, ...
        mean_imp_day00, ...
        std_imp_day00, 'o', 'LineWidth', 1.3)
hold on
errorbar( gamryStructure_EIS_cell_Day01_r2(1).f, ...
        mean_imp_day07, ...
        std_imp_day07, 's', 'LineWidth', 1.3)
hold on
errorbar( gamryStructure_EIS_cell_Day01_r2(1).f, ...
        mean_imp_day14, ...
        std_imp_day14, 's', 'LineWidth', 1.3)
    
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')    
xlim([1e3 1e6])
ylabel('mag(Impedance) (Ohm)')
xlabel('Frequency (Hz)')
legend('Day 00', 'Day 07', 'Day 14')

%%
figure
C_array = [1.175e-11, 1.29e-11, 11.8e-12; % repeating one here since 4 failed. Was able to fit from 10e3 to 1e6, but the phase was very low from 90. Did not include for this reason.
           8.31e-12, 1.22e-11, 11.8e-12;
           1.04e-11, 1.12e-11, 12.19e-12];
dates = {'Day 0' 'Day 7' 'Day 14'};

fig_box = boxplot(1e12*C_array, dates, 'Color','k');
ylabel('Capacitance (pF)')
set(fig_box, 'LineWidth', 1.5)