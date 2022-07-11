%% experiment_cellImpedance_overTime_start20220415
% Looking for changes in impedance across XX days as we try to grow a
% monolayer of 3 different cell types on the cellulose membranes. Looking
% at astrocytes, MDCK epithelial cells, and meningeal cells
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
    extractImpedanceDataGlobal('..\rawData\Gamry\20220415_WPI03_MemCell_Day02');
[gamryStructure_EIS_cell_Day02] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220418_WPI03_MemCell_Day05');
[gamryStructure_EIS_cell_Day03] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220420_WPI03_MemCell_Day07');
[gamryStructure_EIS_cell_Day04] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220425_WPI03_MemCell_Day12');
% [gamryStructure_EIS_cell_Day05] = ...
%     extractImpedanceDataGlobal('..\rawData\Gamry\20220216_WPI02_GelCell_Day05\EIS');
% [gamryStructure_EIS_cell_Day05] = ...
%     extractImpedanceDataGlobal('..\rawData\Gamry\20220123_WPI02_GelCell_Day05');

%% Individual Measurement Plots
% Day 01 %
figure
yyaxis left
plot_order = [2 3 4 5 7 8 9 10 12 13 14 15];
for ii = 1:length(plot_order)
    jj = plot_order(ii);
    loglog( gamryStructure_EIS_cell_Day01(jj).f, ...
            gamryStructure_EIS_cell_Day01(jj).Zmag )
    hold on
end
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')

yyaxis right
for ii = 1:length(plot_order)
    jj = plot_order(ii);
    loglog( gamryStructure_EIS_cell_Day01(jj).f, ...
            gamryStructure_EIS_cell_Day01(jj).Phase )
    hold on
end
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')
xlim([9.9 1e6])
legend('CM-A', 'A-M1', 'A-M2', 'A-M3', 'CM-M', 'M-M1','M-M2', 'M-M3', ...
       'CM-K', 'K-M1', 'K-M2', 'K-M3')
title('Day 02 - Individual Measurements')

% Day 02 %
figure
yyaxis left
plot_order = [1:30];
for ii = 1:length(plot_order)
    jj = plot_order(ii);
    loglog( gamryStructure_EIS_cell_Day02(jj).f, ...
            gamryStructure_EIS_cell_Day02(jj).Zmag )
    hold on
end
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')

yyaxis right
for ii = 1:length(plot_order)
    jj = plot_order(ii);
    loglog( gamryStructure_EIS_cell_Day02(jj).f, ...
            gamryStructure_EIS_cell_Day02(jj).Phase )
    hold on
end
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')
xlim([9.9 1e6])
% legend('CM-A', 'A-M1', 'A-M2', 'A-M3', 'CM-M', 'M-M1','M-M2', 'M-M3', ...
%        'CM-K', 'K-M1', 'K-M2', 'K-M3')
title('Day 05 - Individual Measurements')

% Day 03 %
figure
yyaxis left
plot_order = [1:10];
for ii = 1:length(plot_order)
    jj = plot_order(ii);
    loglog( gamryStructure_EIS_cell_Day03(jj).f, ...
            gamryStructure_EIS_cell_Day03(jj).Zmag )
    hold on
end
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')

yyaxis right
for ii = 1:length(plot_order)
    jj = plot_order(ii);
    loglog( gamryStructure_EIS_cell_Day03(jj).f, ...
            gamryStructure_EIS_cell_Day03(jj).Phase )
    hold on
end
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')
xlim([9.9 1e6])
% legend('CM-A', 'A-M1', 'A-M2', 'A-M3', 'CM-M', 'M-M1','M-M2', 'M-M3', ...
%        'CM-K', 'K-M1', 'K-M2', 'K-M3')
title('Day 07 - Individual Measurements')

% Day 04 %
figure
yyaxis left
plot_order = [1:10];
for ii = 1:length(plot_order)
    jj = plot_order(ii);
    loglog( gamryStructure_EIS_cell_Day04(jj).f, ...
            gamryStructure_EIS_cell_Day04(jj).Zmag )
    hold on
end
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')

yyaxis right
for ii = 1:length(plot_order)
    jj = plot_order(ii);
    loglog( gamryStructure_EIS_cell_Day04(jj).f, ...
            gamryStructure_EIS_cell_Day04(jj).Phase )
    hold on
end
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')
xlim([9.9 1e6])
% legend('CM-A', 'A-M1', 'A-M2', 'A-M3', 'CM-M', 'M-M1','M-M2', 'M-M3', ...
%        'CM-K', 'K-M1', 'K-M2', 'K-M3')
title('Day 12 - Individual Measurements')
%% Plot Averages
% Day 2% 
pointerArray = [ 3  4  5;   % Astro
                 8  9 10;   % Meningeal
                13 14 15;   % MDCK
                 2  7 12];  % CM
pointer_row = 1;
numMeasures = length(pointerArray);
figure
for kk = 1:4
    meanArray = [];
    PhaseArray = [];
    meanMeanArray = [];
    stdMeanArray = [];
    meanPhaseArray = [];
    stdPhaseArray = [];
    for ii = 1:3
        jj = pointerArray(pointer_row, ii);
        meanArray = [meanArray gamryStructure_EIS_cell_Day01(jj).Zmag];
        PhaseArray = [PhaseArray gamryStructure_EIS_cell_Day01(jj).Phase];
    end
    
    meanMeanArray = mean(meanArray, 2);
    stdMeanArray = std(meanArray, 0, 2);
    meanPhaseArray = mean(PhaseArray, 2);
    stdPhaseArray = std(PhaseArray, 0, 2);
    
    %Plot 
    yyaxis left
    errorbar( gamryStructure_EIS_cell_Day01(1).f, ...
            meanMeanArray, ...
            stdMeanArray, 'LineWidth', 1.0)
    hold on
    xlabel('Frequency (Hz)')
    ylabel('mag(Impedance) (Ohm)')
    set(gca, 'YScale', 'log')
    set(gca, 'XScale', 'log')
    yyaxis right
    errorbar( gamryStructure_EIS_cell_Day01(1).f, ...
            meanPhaseArray, ...
            stdPhaseArray, 'LineWidth', 1.0)
    hold on
    set(gca, 'XScale', 'log')
    ylabel('Phase')
    
    pointer_row = pointer_row + 1;
end
legend('Astrocytes', 'Meningeal', 'MDCK', 'Culture Media')

% Day 5 - 3e% 
pointerArray = [ 6  8 10;   % Astro
                26 28 30;   % Meningeal
                16 18 20;   % MDCK
                 4 13 24];  % CM
pointer_row = 1;
numMeasures = length(pointerArray);
figure
for kk = 1:4
    meanArray = [];
    PhaseArray = [];
    meanMeanArray = [];
    stdMeanArray = [];
    meanPhaseArray = [];
    stdPhaseArray = [];
    for ii = 1:3
        jj = pointerArray(pointer_row, ii);
        meanArray = [meanArray gamryStructure_EIS_cell_Day02(jj).Zmag];
        PhaseArray = [PhaseArray gamryStructure_EIS_cell_Day02(jj).Phase];
    end
    
    meanMeanArray = mean(meanArray, 2);
    stdMeanArray = std(meanArray, 0, 2);
    meanPhaseArray = mean(PhaseArray, 2);
    stdPhaseArray = std(PhaseArray, 0, 2);
    
    %Plot 
    yyaxis left
    errorbar( gamryStructure_EIS_cell_Day02(1).f, ...
            meanMeanArray, ...
            stdMeanArray, 'LineWidth', 1.0)
    hold on
    xlabel('Frequency (Hz)')
    ylabel('mag(Impedance) (Ohm)')
    set(gca, 'YScale', 'log')
    set(gca, 'XScale', 'log')
    yyaxis right
    errorbar( gamryStructure_EIS_cell_Day02(1).f, ...
            meanPhaseArray, ...
            stdPhaseArray, 'LineWidth', 1.0)
    hold on
    set(gca, 'XScale', 'log')
    ylabel('Phase')
    
    pointer_row = pointer_row + 1;
end
legend('Astrocytes', 'Meningeal', 'MDCK', 'Culture Media')

% Day 7 - 3e% 
pointerArray = [ %6  8 10;   % Astro
                %26 28 30;   % Meningeal
                 6  8 10;   % MDCK
                 3  4  4];  % CM, repeating one measurement to make 3
pointer_row = 1;
[numCellTypes, numMeasures] = size(pointerArray);
figure
for kk = 1:numCellTypes
    meanArray = [];
    PhaseArray = [];
    meanMeanArray = [];
    stdMeanArray = [];
    meanPhaseArray = [];
    stdPhaseArray = [];
    for ii = 1:numMeasures
        jj = pointerArray(pointer_row, ii);
        meanArray = [meanArray gamryStructure_EIS_cell_Day03(jj).Zmag];
        PhaseArray = [PhaseArray gamryStructure_EIS_cell_Day03(jj).Phase];
    end
    
    meanMeanArray = mean(meanArray, 2);
    stdMeanArray = std(meanArray, 0, 2);
    meanPhaseArray = mean(PhaseArray, 2);
    stdPhaseArray = std(PhaseArray, 0, 2);
    
    %Plot 
    yyaxis left
    errorbar( gamryStructure_EIS_cell_Day03(1).f, ...
            meanMeanArray, ...
            stdMeanArray, 'LineWidth', 1.0)
    hold on
    xlabel('Frequency (Hz)')
    ylabel('mag(Impedance) (Ohm)')
    set(gca, 'YScale', 'log')
    set(gca, 'XScale', 'log')
    yyaxis right
    errorbar( gamryStructure_EIS_cell_Day03(1).f, ...
            meanPhaseArray, ...
            stdPhaseArray, 'LineWidth', 1.0)
    hold on
    set(gca, 'XScale', 'log')
    ylabel('Phase')
    
    pointer_row = pointer_row + 1;
end
legend('MDCK', 'Culture Media')

% Day 12 - 3e% 
pointerArray = [ %6  8 10;   % Astro
                %26 28 30;   % Meningeal
                 6  8 10;   % MDCK
                 3  4  4];  % CM, repeating one measurement to make 3
pointer_row = 1;
[numCellTypes, numMeasures] = size(pointerArray);
figure
for kk = 1:numCellTypes
    meanArray = [];
    PhaseArray = [];
    meanMeanArray = [];
    stdMeanArray = [];
    meanPhaseArray = [];
    stdPhaseArray = [];
    for ii = 1:numMeasures
        jj = pointerArray(pointer_row, ii);
        meanArray = [meanArray gamryStructure_EIS_cell_Day04(jj).Zmag];
        PhaseArray = [PhaseArray gamryStructure_EIS_cell_Day04(jj).Phase];
    end
    
    meanMeanArray = mean(meanArray, 2);
    stdMeanArray = std(meanArray, 0, 2);
    meanPhaseArray = mean(PhaseArray, 2);
    stdPhaseArray = std(PhaseArray, 0, 2);
    
    %Plot 
    yyaxis left
    errorbar( gamryStructure_EIS_cell_Day04(1).f, ...
            meanMeanArray, ...
            stdMeanArray, 'LineWidth', 1.0)
    hold on
    xlabel('Frequency (Hz)')
    ylabel('mag(Impedance) (Ohm)')
    set(gca, 'YScale', 'log')
    set(gca, 'XScale', 'log')
    yyaxis right
    errorbar( gamryStructure_EIS_cell_Day04(1).f, ...
            meanPhaseArray, ...
            stdPhaseArray, 'LineWidth', 1.0)
    hold on
    set(gca, 'XScale', 'log')
    ylabel('Phase')
    
    pointer_row = pointer_row + 1;
end
legend('MDCK', 'Culture Media')

%% 2e
% Day 5 - 2e% 
pointerArray = [ 5  7  9;   % Astro
                25 27 29;   % Meningeal
                15 17 19;   % MDCK
                 2 11 22];  % CM
pointer_row = 1;
numMeasures = length(pointerArray);
figure
for kk = 1:4
    meanArray = [];
    PhaseArray = [];
    meanMeanArray = [];
    stdMeanArray = [];
    meanPhaseArray = [];
    stdPhaseArray = [];
    for ii = 1:3
        jj = pointerArray(pointer_row, ii);
        meanArray = [meanArray gamryStructure_EIS_cell_Day02(jj).Zmag];
        PhaseArray = [PhaseArray gamryStructure_EIS_cell_Day02(jj).Phase];
    end
    
    meanMeanArray = mean(meanArray, 2);
    stdMeanArray = std(meanArray, 0, 2);
    meanPhaseArray = mean(PhaseArray, 2);
    stdPhaseArray = std(PhaseArray, 0, 2);
    
    %Plot 
    yyaxis left
    errorbar( gamryStructure_EIS_cell_Day02(1).f, ...
            meanMeanArray, ...
            stdMeanArray, 'LineWidth', 1.0)
    hold on
    xlabel('Frequency (Hz)')
    ylabel('mag(Impedance) (Ohm)')
    set(gca, 'YScale', 'log')
    set(gca, 'XScale', 'log')
    yyaxis right
    errorbar( gamryStructure_EIS_cell_Day02(1).f, ...
            meanPhaseArray, ...
            stdPhaseArray, 'LineWidth', 1.0)
    hold on
    set(gca, 'XScale', 'log')
    ylabel('Phase')
    
    pointer_row = pointer_row + 1;
end
legend('Astrocytes', 'Meningeal', 'MDCK', 'Culture Media')

% Day 7 - 2e% 
pointerArray = [ %6  8 10;   % Astro
                %26 28 30;   % Meningeal
                 5  7  9;   % MDCK
                 1  2  2];  % CM, repeating one measurement to make 3
pointer_row = 1;
[numCellTypes, numMeasures] = size(pointerArray);
figure
for kk = 1:numCellTypes
    meanArray = [];
    PhaseArray = [];
    meanMeanArray = [];
    stdMeanArray = [];
    meanPhaseArray = [];
    stdPhaseArray = [];
    for ii = 1:numMeasures
        jj = pointerArray(pointer_row, ii);
        meanArray = [meanArray gamryStructure_EIS_cell_Day03(jj).Zmag];
        PhaseArray = [PhaseArray gamryStructure_EIS_cell_Day03(jj).Phase];
    end
    
    meanMeanArray = mean(meanArray, 2);
    stdMeanArray = std(meanArray, 0, 2);
    meanPhaseArray = mean(PhaseArray, 2);
    stdPhaseArray = std(PhaseArray, 0, 2);
    
    %Plot 
    yyaxis left
    errorbar( gamryStructure_EIS_cell_Day03(1).f, ...
            meanMeanArray, ...
            stdMeanArray, 'LineWidth', 1.0)
    hold on
    xlabel('Frequency (Hz)')
    ylabel('mag(Impedance) (Ohm)')
    set(gca, 'YScale', 'log')
    set(gca, 'XScale', 'log')
    yyaxis right
    errorbar( gamryStructure_EIS_cell_Day03(1).f, ...
            meanPhaseArray, ...
            stdPhaseArray, 'LineWidth', 1.0)
    hold on
    set(gca, 'XScale', 'log')
    ylabel('Phase')
    
    pointer_row = pointer_row + 1;
end
legend('MDCK', 'Culture Media')
title('Day 07 2e')
% Do start to see some variation here on day 07. Especially at high
% frequency impedance. Also phase across the spectrum.

% Day 12 - 2e% 
pointerArray = [ %6  8 10;   % Astro
                %26 28 30;   % Meningeal
                 5  7  9;   % MDCK
                 1  2  2];  % CM, repeating one measurement to make 3
pointer_row = 1;
[numCellTypes, numMeasures] = size(pointerArray);
figure
for kk = 1:numCellTypes
    meanArray = [];
    PhaseArray = [];
    meanMeanArray = [];
    stdMeanArray = [];
    meanPhaseArray = [];
    stdPhaseArray = [];
    for ii = 1:numMeasures
        jj = pointerArray(pointer_row, ii);
        meanArray = [meanArray gamryStructure_EIS_cell_Day04(jj).Zmag];
        PhaseArray = [PhaseArray gamryStructure_EIS_cell_Day04(jj).Phase];
    end
    
    meanMeanArray = mean(meanArray, 2);
    stdMeanArray = std(meanArray, 0, 2);
    meanPhaseArray = mean(PhaseArray, 2);
    stdPhaseArray = std(PhaseArray, 0, 2);
    
    %Plot 
    yyaxis left
    errorbar( gamryStructure_EIS_cell_Day04(1).f, ...
            meanMeanArray, ...
            stdMeanArray, 'LineWidth', 1.0)
    hold on
    xlabel('Frequency (Hz)')
    ylabel('mag(Impedance) (Ohm)')
    set(gca, 'YScale', 'log')
    set(gca, 'XScale', 'log')
    yyaxis right
    errorbar( gamryStructure_EIS_cell_Day04(1).f, ...
            meanPhaseArray, ...
            stdPhaseArray, 'LineWidth', 1.0)
    hold on
    set(gca, 'XScale', 'log')
    ylabel('Phase')
    
    pointer_row = pointer_row + 1;
end
legend('MDCK', 'Culture Media')
title('Day 12 2e')
% Pretty large differences for this day for both 2e and 3e, but I believe
% they were mostly driven by membrane number 2, which makes me slightly
% suspicious. 
%% 2 vs 3e comparisons
% Day 5 - Astro             
pointerArray = [ 5  7  9;   % Astro - 2e
                 6  8 10];   % Astro - 3e

pointer_row = 1;
numMeasures = length(pointerArray);
figure
for kk = 1:2
    meanArray = [];
    PhaseArray = [];
    meanMeanArray = [];
    stdMeanArray = [];
    meanPhaseArray = [];
    stdPhaseArray = [];
    for ii = 1:3
        jj = pointerArray(pointer_row, ii);
        meanArray = [meanArray gamryStructure_EIS_cell_Day02(jj).Zmag];
        PhaseArray = [PhaseArray gamryStructure_EIS_cell_Day02(jj).Phase];
    end
    
    meanMeanArray = mean(meanArray, 2);
    stdMeanArray = std(meanArray, 0, 2);
    meanPhaseArray = mean(PhaseArray, 2);
    stdPhaseArray = std(PhaseArray, 0, 2);
    
    %Plot 
    yyaxis left
    errorbar( gamryStructure_EIS_cell_Day02(1).f, ...
            meanMeanArray, ...
            stdMeanArray, 'LineWidth', 1.0)
    hold on
    xlabel('Frequency (Hz)')
    ylabel('mag(Impedance) (Ohm)')
    set(gca, 'YScale', 'log')
    set(gca, 'XScale', 'log')
    yyaxis right
    errorbar( gamryStructure_EIS_cell_Day02(1).f, ...
            meanPhaseArray, ...
            stdPhaseArray, 'LineWidth', 1.0)
    hold on
    set(gca, 'XScale', 'log')
    ylabel('Phase')
    
    pointer_row = pointer_row + 1;
end
legend('Astrocytes - 2e', 'Astrocytes - 3e')

% Day 5 - Menin             
pointerArray = [25 27 29;   % 2e
                26 28 30];   %3e

pointer_row = 1;
numMeasures = length(pointerArray);
figure
for kk = 1:2
    meanArray = [];
    PhaseArray = [];
    meanMeanArray = [];
    stdMeanArray = [];
    meanPhaseArray = [];
    stdPhaseArray = [];
    for ii = 1:3
        jj = pointerArray(pointer_row, ii);
        meanArray = [meanArray gamryStructure_EIS_cell_Day02(jj).Zmag];
        PhaseArray = [PhaseArray gamryStructure_EIS_cell_Day02(jj).Phase];
    end
    
    meanMeanArray = mean(meanArray, 2);
    stdMeanArray = std(meanArray, 0, 2);
    meanPhaseArray = mean(PhaseArray, 2);
    stdPhaseArray = std(PhaseArray, 0, 2);
    
    %Plot 
    yyaxis left
    errorbar( gamryStructure_EIS_cell_Day02(1).f, ...
            meanMeanArray, ...
            stdMeanArray, 'LineWidth', 1.0)
    hold on
    xlabel('Frequency (Hz)')
    ylabel('mag(Impedance) (Ohm)')
    set(gca, 'YScale', 'log')
    set(gca, 'XScale', 'log')
    yyaxis right
    errorbar( gamryStructure_EIS_cell_Day02(1).f, ...
            meanPhaseArray, ...
            stdPhaseArray, 'LineWidth', 1.0)
    hold on
    set(gca, 'XScale', 'log')
    ylabel('Phase')
    
    pointer_row = pointer_row + 1;
end
legend('Menin - 2e', 'Menin - 3e')

% Day 5 - CM             
pointerArray = [2 11 22;   % 2e
                4 13 24];   %3e

pointer_row = 1;
numMeasures = length(pointerArray);
figure
for kk = 1:2
    meanArray = [];
    PhaseArray = [];
    meanMeanArray = [];
    stdMeanArray = [];
    meanPhaseArray = [];
    stdPhaseArray = [];
    for ii = 1:3
        jj = pointerArray(pointer_row, ii);
        meanArray = [meanArray gamryStructure_EIS_cell_Day02(jj).Zmag];
        PhaseArray = [PhaseArray gamryStructure_EIS_cell_Day02(jj).Phase];
    end
    
    meanMeanArray = mean(meanArray, 2);
    stdMeanArray = std(meanArray, 0, 2);
    meanPhaseArray = mean(PhaseArray, 2);
    stdPhaseArray = std(PhaseArray, 0, 2);
    
    %Plot 
    yyaxis left
    errorbar( gamryStructure_EIS_cell_Day02(1).f, ...
            meanMeanArray, ...
            stdMeanArray, 'LineWidth', 1.0)
    hold on
    xlabel('Frequency (Hz)')
    ylabel('mag(Impedance) (Ohm)')
    set(gca, 'YScale', 'log')
    set(gca, 'XScale', 'log')
    yyaxis right
    errorbar( gamryStructure_EIS_cell_Day02(1).f, ...
            meanPhaseArray, ...
            stdPhaseArray, 'LineWidth', 1.0)
    hold on
    set(gca, 'XScale', 'log')
    ylabel('Phase')
    
    pointer_row = pointer_row + 1;
end
legend('CM - 2e', 'CM - 3e')