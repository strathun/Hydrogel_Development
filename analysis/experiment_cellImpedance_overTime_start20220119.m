%% experiment_cellImpedance_overTime_start20220119
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
    extractImpedanceDataGlobal('..\rawData\Gamry\20220120_WPI02_GelCell_Day01');
[gamryStructure_EIS_cell_Day02] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220121_WPI02_GelCell_Day02');
% [gamryStructure_EIS_cell_Day03] = ...
%     extractImpedanceDataGlobal('..\rawData\Gamry\20211221_WPI02_InVitro_GelCM\EIS');

%% Group Data
% % Started on this, but only got to CELL Day 1/ 01/20. Go back to this when
% % ready for the stats.
% % CELL Day 1% 
% meanArray = [];
% PhaseArray = [];
% meanMeanArray = [];
% stdMeanArray = [];
% meanPhaseArray = [];
% stdPhaseArray = [];
% 
% % 01/19 
% pointerArray = [3 4 5 6]; 
% numMeasures = length(pointerArray);
% for ii = 1:numMeasures
%     jj = pointerArray(ii);
%     meanArray = [meanArray gamryStructure_EIS_cell_Day01(jj).Zmag];
%     PhaseArray = [PhaseArray gamryStructure_EIS_cell_Day01(jj).Phase];
% end
% 
% % 01/20
% pointerArray = [3 4 5 6]; 
% numMeasures = length(pointerArray);
% for ii = 1:numMeasures
%     jj = pointerArray(ii);
%     meanArray = [meanArray gamryStructure_EIS_cell_Day02(jj).Zmag];
%     PhaseArray = [PhaseArray gamryStructure_EIS_cell_Day02(jj).Phase];
% end
% 
% gelDay00_mag = meanArray;
% gelDay00_phase = PhaseArray;
% 
% % GEL Day 7% 
% meanArray = [];
% PhaseArray = [];
% meanMeanArray = [];
% stdMeanArray = [];
% meanPhaseArray = [];
% stdPhaseArray = [];
% 
% % 12/21
% pointerArray = [6 9 12]; 
% numMeasures = length(pointerArray);
% for ii = 1:numMeasures
%     jj = pointerArray(ii);
%     meanArray = [meanArray gamryStructure_EIS_cell_Day03(jj).Zmag];
%     PhaseArray = [PhaseArray gamryStructure_EIS_cell_Day03(jj).Phase];
% end
% 
% gelDay07_mag = meanArray;
% gelDay07_phase = PhaseArray;
% 
% % CULTURE MEDIA % 
% meanArray = [];
% PhaseArray = [];
% meanMeanArray = [];
% stdMeanArray = [];
% meanPhaseArray = [];
% stdPhaseArray = [];
% 
% % 11/24 
% pointerArray = [9]; 
% numMeasures = length(pointerArray);
% for ii = 1:numMeasures
%     jj = pointerArray(ii);
%     meanArray = [meanArray gamryStructure_EIS_cell_Day01(jj).Zmag];
%     PhaseArray = [PhaseArray gamryStructure_EIS_cell_Day01(jj).Phase];
% end
% 
% % 12/08 
% pointerArray = [3]; 
% numMeasures = length(pointerArray);
% for ii = 1:numMeasures
%     jj = pointerArray(ii);
%     meanArray = [meanArray gamryStructure_EIS_cell_Day02(jj).Zmag];
%     PhaseArray = [PhaseArray gamryStructure_EIS_cell_Day02(jj).Phase];
% end
% 
% % 12/21
% pointerArray = [3]; 
% numMeasures = length(pointerArray);
% for ii = 1:numMeasures
%     jj = pointerArray(ii);
%     meanArray = [meanArray gamryStructure_EIS_cell_Day03(jj).Zmag];
%     PhaseArray = [PhaseArray gamryStructure_EIS_cell_Day03(jj).Phase];
% end
% 
% cm_mag = meanArray;
% cm_phase = PhaseArray;

%% Statistics
% % Group data for Impedance ANOVA
% % Coloums = groups; rows = measurements
% for ii = 1:51
% %     freq_index = 51;
%     mag_data(:,1) = gelDay00_mag(ii,1:3).';
%     mag_data(:,2) = gelDay07_mag(ii,:).';
%     mag_data(:,3) = cm_mag(ii,:).';
% 
%     [p,tbl,stats] = anova1(mag_data);
%     ppp(ii) = p;
% end
% sig_ps_mag = find(ppp<0.05);
% %% Statistics
% % Group data for Impedance ANOVA
% % Coloums = groups; rows = measurements
% for ii = 1:51
% %     freq_index = 51;
%     phase_data(:,1) = gelDay00_phase(ii,1:3).';
%     phase_data(:,2) = gelDay07_phase(ii,:).';
%     phase_data(:,3) = cm_phase(ii,:).';
% 
%     [p,tbl,stats] = anova1(phase_data);
%     ppp(ii) = p;
% end
% 
% sig_ps_phase = find(ppp<0.05);
% 
% %% Calculate which groups are different from phase
% freq_index = 51;
% phase_data(:,1) = gelDay00_phase(freq_index,1:3).';
% phase_data(:,2) = gelDay07_phase(freq_index,:).';
% phase_data(:,3) = cm_phase(freq_index,:).';
% 
% [p,tbl,stats] = anova1(phase_data);
% multcompare(stats)

%%
% 

%% Individual Measurement Plots
% Day 01 %
yyaxis left
for ii = 1:length(gamryStructure_EIS_cell_Day01)
    loglog( gamryStructure_EIS_cell_Day01(ii).f, ...
            gamryStructure_EIS_cell_Day01(ii).Zmag )
    hold on
end
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')

yyaxis right
for ii = 1:length(gamryStructure_EIS_cell_Day01)
    loglog( gamryStructure_EIS_cell_Day01(ii).f, ...
            gamryStructure_EIS_cell_Day01(ii).Phase )
    hold on
end
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')
xlim([9.9 1e6])
legend('CM-r1', 'CM-r2', 'Gel 01', 'Gel 02', 'Gel 03', 'Gel 04')
title('Day 01 - Individual Measurements')
% CM-r1 was a definite outlier. I believe this is because the electrode was
% not fully submerged during this measurement which limited the current and
% with it, the measured impedance. I'm leaving it out of the average plot
% for now. 

% Day 02 %
yyaxis left
for ii = 1:length(gamryStructure_EIS_cell_Day02)
    loglog( gamryStructure_EIS_cell_Day02(ii).f, ...
            gamryStructure_EIS_cell_Day02(ii).Zmag )
    hold on
end
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')

yyaxis right
for ii = 1:length(gamryStructure_EIS_cell_Day02)
    loglog( gamryStructure_EIS_cell_Day02(ii).f, ...
            gamryStructure_EIS_cell_Day02(ii).Phase )
    hold on
end
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')
xlim([9.9 1e6])
legend('CM-r1', 'CM-r2', 'Gel 01', 'Gel 02', 'Gel 03', 'Gel 04')
title('Day 01 - Individual Measurements')

%% Plot Averages

% CELL Day 1% 
meanArray = [];
PhaseArray = [];
meanMeanArray = [];
stdMeanArray = [];
meanPhaseArray = [];
stdPhaseArray = [];

% 01/19
pointerArray = [3 4 5 6]; 
numMeasures = length(pointerArray);
for ii = 1:numMeasures
    jj = pointerArray(ii);
    meanArray = [meanArray gamryStructure_EIS_cell_Day01(jj).Zmag];
    PhaseArray = [PhaseArray gamryStructure_EIS_cell_Day01(jj).Phase];
end

meanMeanArray = mean(meanArray, 2);
stdMeanArray = std(meanArray, 0, 2);
meanPhaseArray = mean(PhaseArray, 2);
stdPhaseArray = std(PhaseArray, 0, 2);

% Plot Cell Data
figure
yyaxis left
errorbar( gamryStructure_EIS_cell_Day01(1).f, ...
        meanMeanArray, ...
        stdMeanArray, 'LineWidth', 1.0)
hold on
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')

yyaxis right
errorbar( gamryStructure_EIS_cell_Day01(1).f, ...
        meanPhaseArray, ...
        stdPhaseArray, 'LineWidth', 1.0)
hold on
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')

% CELL Day 2 % 
meanArray = [];
PhaseArray = [];
meanMeanArray = [];
stdMeanArray = [];
meanPhaseArray = [];
stdPhaseArray = [];

% 01/20
pointerArray = [3 4 5 6]; 
numMeasures = length(pointerArray);
for ii = 1:numMeasures
    jj = pointerArray(ii);
    meanArray = [meanArray gamryStructure_EIS_cell_Day02(jj).Zmag];
    PhaseArray = [PhaseArray gamryStructure_EIS_cell_Day02(jj).Phase];
end

meanMeanArray = mean(meanArray, 2);
stdMeanArray = std(meanArray, 0, 2);
meanPhaseArray = mean(PhaseArray, 2);
stdPhaseArray = std(PhaseArray, 0, 2);

yyaxis left
errorbar( gamryStructure_EIS_cell_Day02(1).f, ...
        meanMeanArray, ...
        stdMeanArray, 'LineWidth', 1.0)
hold on
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')

yyaxis right
errorbar( gamryStructure_EIS_cell_Day02(1).f, ...
        meanPhaseArray, ...
        stdPhaseArray, 'LineWidth', 1.0)
hold on
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')

% % CELL Day 3 % 
% meanArray = [];
% PhaseArray = [];
% meanMeanArray = [];
% stdMeanArray = [];
% meanPhaseArray = [];
% stdPhaseArray = [];
% 
% % 01/21
% pointerArray = [3 4 5 6]; 
% numMeasures = length(pointerArray);
% for ii = 1:numMeasures
%     jj = pointerArray(ii);
%     meanArray = [meanArray gamryStructure_EIS_cell_Day03(jj).Zmag];
%     PhaseArray = [PhaseArray gamryStructure_EIS_cell_Day03(jj).Phase];
% end
% 
% meanMeanArray = mean(meanArray, 2);
% stdMeanArray = std(meanArray, 0, 2);
% meanPhaseArray = mean(PhaseArray, 2);
% stdPhaseArray = std(PhaseArray, 0, 2);
% 
% yyaxis left
% errorbar( gamryStructure_EIS_cell_Day03(1).f, ...
%         meanMeanArray, ...
%         stdMeanArray, 'LineWidth', 2.0)
% hold on
% set(gca, 'YScale', 'log')
% set(gca, 'XScale', 'log')
% xlabel('Frequency (Hz)')
% ylabel('mag(Impedance) (Ohm)')
% 
% yyaxis right
% errorbar( gamryStructure_EIS_cell_Day03(1).f, ...
%         meanPhaseArray, ...
%         stdPhaseArray, 'LineWidth', 2.0)
% hold on
% set(gca, 'XScale', 'log')
% xlabel('Frequency (Hz)')
% ylabel('Phase')

% CULTURE MEDIA % 
meanArray = [];
PhaseArray = [];
meanMeanArray = [];
stdMeanArray = [];
meanPhaseArray = [];
stdPhaseArray = [];

% 01/19
pointerArray = [2]; 
numMeasures = length(pointerArray);
for ii = 1:numMeasures
    jj = pointerArray(ii);
    meanArray = [meanArray gamryStructure_EIS_cell_Day01(jj).Zmag];
    PhaseArray = [PhaseArray gamryStructure_EIS_cell_Day01(jj).Phase];
end

% 01/20 
pointerArray = [1 2]; 
numMeasures = length(pointerArray);
for ii = 1:numMeasures
    jj = pointerArray(ii);
    meanArray = [meanArray gamryStructure_EIS_cell_Day02(jj).Zmag];
    PhaseArray = [PhaseArray gamryStructure_EIS_cell_Day02(jj).Phase];
end
% 
% % 01/21
% pointerArray = [1 2]; 
% numMeasures = length(pointerArray);
% for ii = 1:numMeasures
%     jj = pointerArray(ii);
%     meanArray = [meanArray gamryStructure_EIS_cell_Day03(jj).Zmag];
%     PhaseArray = [PhaseArray gamryStructure_EIS_cell_Day03(jj).Phase];
% end


meanMeanArray = mean(meanArray, 2);
stdMeanArray = std(meanArray, 0, 2);
meanPhaseArray = mean(PhaseArray, 2);
stdPhaseArray = std(PhaseArray, 0, 2);

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
legend('Cells Day 01', 'Cells Day 02', 'CM')

