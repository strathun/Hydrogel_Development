%% experiment_insertInsulation_20220504
% Testing to see if the new double chamber inserts are electrochemically
% insulated. Borrowing some data from previous days. 
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
[gamryStructure_EIS_cell_Day02] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220504_WPI03_Insert_insulation');


%% Individual Measurement Plots
figure(1)
pointer_day1 = 6;
pointer_day2 = [1 2];
colorArray = lines(3);
[~, numRuns] = size(pointer_day1);
for ii = 1:numRuns
    jj = pointer_day1(ii);
    scatter( gamryStructure_EIS_cell_Day01(jj).f, ...
            gamryStructure_EIS_cell_Day01(jj).Zmag, [], ...
            colorArray( ii, : ))
    hold on
end
[~, numRuns] = size(pointer_day2);
for ii = 1:numRuns
    jj = pointer_day2(ii);
    scatter( gamryStructure_EIS_cell_Day02(jj).f, ...
            gamryStructure_EIS_cell_Day02(jj).Zmag, [], ...
            colorArray( ii+1, : ))
    hold on
end

figure(2)
[~, numRuns] = size(pointer_day1);
for ii = 1:numRuns
    jj = pointer_day1(ii);
    scatter( gamryStructure_EIS_cell_Day01(jj).f, ...
            gamryStructure_EIS_cell_Day01(jj).Phase, [], ...
            colorArray( ii, : ))
    hold on
end
[~, numRuns] = size(pointer_day2);
for ii = 1:numRuns
    jj = pointer_day2(ii);
    scatter( gamryStructure_EIS_cell_Day02(jj).f, ...
            gamryStructure_EIS_cell_Day02(jj).Phase, [], ...
            colorArray( ii+1, : ))
    hold on
end
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')
xlim([9.9 1e6])
title('Phase')
% legend(string(display_name))
% title('Day 02 - Individual Measurements')

%% Add trendlines to impedance
figure(1)
pointer_day1 = 6;
pointer_day2 = [1 2];
[~, numRuns] = size(pointer_day1);
for ii = 1:numRuns
    jj = pointer_day1(ii);
    x = gamryStructure_EIS_cell_Day01(jj).f(1:end-20);
    y = gamryStructure_EIS_cell_Day01(jj).Zmag(1:end-20);
    
    fit_vals = polyfit(log(x), log(y), 1);
    fit_line = polyval(fit_vals, log(x));
    plot( x, exp(fit_line) , 'LineWidth', 1.5, 'Color', colorArray( ii, : ))
    hold on
end
[~, numRuns] = size(pointer_day2);
for ii = 1:numRuns
    jj = pointer_day2(ii);
    x = gamryStructure_EIS_cell_Day02(jj).f(1:end-20);
    y = gamryStructure_EIS_cell_Day02(jj).Zmag(1:end-20);
    
    fit_vals = polyfit(log(x), log(y), 1);
    fit_line = polyval(fit_vals, log(x));
    plot( x, exp(fit_line) , 'LineWidth', 1.5, 'Color', colorArray( ii+1, : ))
    hold on
end

set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
xlim([9.9 1e6])
title('Impedance')
legend('Old Model', 'Commercial Transwell', 'New Model')

% Impedance looks to be pretty similar. Or at least they all look to be
% capacitors. Should be fine to consider open circuit. 