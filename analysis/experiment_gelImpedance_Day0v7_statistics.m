%% experiment_gelImpedance_Day0v7_statistics
% Comparing day 0 impedance of the gels to day 07 (and also culture media)
% For now, will be doing a one-way ANOVA without repeated measures, and
% just do a seperate one for 3 different frequencies, 10, 1kHz and max
% frequency. Here, I'm doing it for all of them, but I'll just show the
% stats for these in the paper. The reason I'm not doing repeated measures
% is that I'm not comparing the frequencies to each other. I want to do a
% completely seperate test at each frequency. Repeated measures, if I
% understand it correctly, would compare the mean of day1, day7 and CM at 
% freq. x with the means of those 3 groups to all the other freqs. This is 
% not what I want! 

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
[gamryStructure_EIS_gel1_Day00] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20211123_WPI02_InVitro_GelCM\EIS');
[gamryStructure_EIS_gel2_Day00] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20211208_WPI02_InVitro_GelCM\EIS');
[gamryStructure_EIS_gel3_Day07] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20211221_WPI02_InVitro_GelCM\EIS');

%% Group Data

% GEL Day 0% 
meanArray = [];
PhaseArray = [];
meanMeanArray = [];
stdMeanArray = [];
meanPhaseArray = [];
stdPhaseArray = [];

% 11/24 
pointerArray = [12 24]; 
numMeasures = length(pointerArray);
for ii = 1:numMeasures
    jj = pointerArray(ii);
    meanArray = [meanArray gamryStructure_EIS_gel1_Day00(jj).Zmag];
    PhaseArray = [PhaseArray gamryStructure_EIS_gel1_Day00(jj).Phase];
end

% 12/08 
pointerArray = [6 9]; 
numMeasures = length(pointerArray);
for ii = 1:numMeasures
    jj = pointerArray(ii);
    meanArray = [meanArray gamryStructure_EIS_gel2_Day00(jj).Zmag];
    PhaseArray = [PhaseArray gamryStructure_EIS_gel2_Day00(jj).Phase];
end

gelDay00_mag = meanArray;
gelDay00_phase = PhaseArray;

% GEL Day 7% 
meanArray = [];
PhaseArray = [];
meanMeanArray = [];
stdMeanArray = [];
meanPhaseArray = [];
stdPhaseArray = [];

% 12/21
pointerArray = [6 9 12]; 
numMeasures = length(pointerArray);
for ii = 1:numMeasures
    jj = pointerArray(ii);
    meanArray = [meanArray gamryStructure_EIS_gel3_Day07(jj).Zmag];
    PhaseArray = [PhaseArray gamryStructure_EIS_gel3_Day07(jj).Phase];
end

gelDay07_mag = meanArray;
gelDay07_phase = PhaseArray;

% CULTURE MEDIA % 
meanArray = [];
PhaseArray = [];
meanMeanArray = [];
stdMeanArray = [];
meanPhaseArray = [];
stdPhaseArray = [];

% 11/24 
pointerArray = [9]; 
numMeasures = length(pointerArray);
for ii = 1:numMeasures
    jj = pointerArray(ii);
    meanArray = [meanArray gamryStructure_EIS_gel1_Day00(jj).Zmag];
    PhaseArray = [PhaseArray gamryStructure_EIS_gel1_Day00(jj).Phase];
end

% 12/08 
pointerArray = [3]; 
numMeasures = length(pointerArray);
for ii = 1:numMeasures
    jj = pointerArray(ii);
    meanArray = [meanArray gamryStructure_EIS_gel2_Day00(jj).Zmag];
    PhaseArray = [PhaseArray gamryStructure_EIS_gel2_Day00(jj).Phase];
end

% 12/21
pointerArray = [3]; 
numMeasures = length(pointerArray);
for ii = 1:numMeasures
    jj = pointerArray(ii);
    meanArray = [meanArray gamryStructure_EIS_gel3_Day07(jj).Zmag];
    PhaseArray = [PhaseArray gamryStructure_EIS_gel3_Day07(jj).Phase];
end

cm_mag = meanArray;
cm_phase = PhaseArray;

%% Statistics
% Group data for Impedance ANOVA
% Coloums = groups; rows = measurements
for ii = 1:51
%     freq_index = 51;
    mag_data(:,1) = gelDay00_mag(ii,1:3).';
    mag_data(:,2) = gelDay07_mag(ii,:).';
    mag_data(:,3) = cm_mag(ii,:).';

    [p,tbl,stats] = anova1(mag_data);
    ppp(ii) = p;
end
sig_ps_mag = find(ppp<0.05);
%% Statistics
% Group data for Impedance ANOVA
% Coloums = groups; rows = measurements
for ii = 1:51
%     freq_index = 51;
    phase_data(:,1) = gelDay00_phase(ii,1:3).';
    phase_data(:,2) = gelDay07_phase(ii,:).';
    phase_data(:,3) = cm_phase(ii,:).';

    [p,tbl,stats] = anova1(phase_data);
    ppp(ii) = p;
end

sig_ps_phase = find(ppp<0.05);

%% Calculate which groups are different from phase
freq_index = 51;
phase_data(:,1) = gelDay00_phase(freq_index,1:3).';
phase_data(:,2) = gelDay07_phase(freq_index,:).';
phase_data(:,3) = cm_phase(freq_index,:).';

[p,tbl,stats] = anova1(phase_data);
multcompare(stats)

%%
% Day 00 and culture media are significantly different at 10Hz. This is
% actually interesting. It suggests that over time the gels become more
% like the culture media (slightly anyway). Looking at the plot, it's
% obvious that this is not a dramatic trend, or consistent across
% frequencies. 
%% IEEE EMBC Plot

% GEL Day 0% 
meanArray = [];
PhaseArray = [];
meanMeanArray = [];
stdMeanArray = [];
meanPhaseArray = [];
stdPhaseArray = [];

% 11/24 
pointerArray = [12 24]; 
numMeasures = length(pointerArray);
for ii = 1:numMeasures
    jj = pointerArray(ii);
    meanArray = [meanArray gamryStructure_EIS_gel1_Day00(jj).Zmag];
    PhaseArray = [PhaseArray gamryStructure_EIS_gel1_Day00(jj).Phase];
end

% 12/08 
pointerArray = [6]; % Note, this needs to be fixed in the actual figure
numMeasures = length(pointerArray);
for ii = 1:numMeasures
    jj = pointerArray(ii);
    meanArray = [meanArray gamryStructure_EIS_gel2_Day00(jj).Zmag];
    PhaseArray = [PhaseArray gamryStructure_EIS_gel2_Day00(jj).Phase];
end

meanMeanArray = mean(meanArray, 2);
stdMeanArray = std(meanArray, 0, 2);
meanPhaseArray = mean(PhaseArray, 2);
stdPhaseArray = std(PhaseArray, 0, 2);

figure
yyaxis left
errorbar( gamryStructure_EIS_gel2_Day00(1).f, ...
        meanMeanArray, ...
        stdMeanArray, 'LineWidth', 2.0)
hold on
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
% xlim([10 1e5])

yyaxis right
errorbar( gamryStructure_EIS_gel2_Day00(1).f, ...
        meanPhaseArray, ...
        stdPhaseArray, 'LineWidth', 2.0)
hold on
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')
% xlim([10 1e5])
% legend('Gel')
% title('CM vs Gel')

% GEL Day 7% 
meanArray = [];
PhaseArray = [];
meanMeanArray = [];
stdMeanArray = [];
meanPhaseArray = [];
stdPhaseArray = [];

% 12/21
pointerArray = [6 9 12]; 
numMeasures = length(pointerArray);
for ii = 1:numMeasures
    jj = pointerArray(ii);
    meanArray = [meanArray gamryStructure_EIS_gel3_Day07(jj).Zmag];
    PhaseArray = [PhaseArray gamryStructure_EIS_gel3_Day07(jj).Phase];
end

meanMeanArray = mean(meanArray, 2);
stdMeanArray = std(meanArray, 0, 2);
meanPhaseArray = mean(PhaseArray, 2);
stdPhaseArray = std(PhaseArray, 0, 2);

yyaxis left
errorbar( gamryStructure_EIS_gel3_Day07(1).f, ...
        meanMeanArray, ...
        stdMeanArray, 'LineWidth', 2.0)
hold on
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
% xlim([10 1e5])

yyaxis right
errorbar( gamryStructure_EIS_gel3_Day07(1).f, ...
        meanPhaseArray, ...
        stdPhaseArray, 'LineWidth', 2.0)
hold on
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')
% xlim([10 1e5])
% legend('Gel')
% title('CM vs Gel')

% CULTURE MEDIA % 
meanArray = [];
PhaseArray = [];
meanMeanArray = [];
stdMeanArray = [];
meanPhaseArray = [];
stdPhaseArray = [];

% 11/24 
pointerArray = [9]; 
numMeasures = length(pointerArray);
for ii = 1:numMeasures
    jj = pointerArray(ii);
    meanArray = [meanArray gamryStructure_EIS_gel1_Day00(jj).Zmag];
    PhaseArray = [PhaseArray gamryStructure_EIS_gel1_Day00(jj).Phase];
end

% 12/08 
pointerArray = [3]; 
numMeasures = length(pointerArray);
for ii = 1:numMeasures
    jj = pointerArray(ii);
    meanArray = [meanArray gamryStructure_EIS_gel2_Day00(jj).Zmag];
    PhaseArray = [PhaseArray gamryStructure_EIS_gel2_Day00(jj).Phase];
end

% 12/21
pointerArray = [3]; 
numMeasures = length(pointerArray);
for ii = 1:numMeasures
    jj = pointerArray(ii);
    meanArray = [meanArray gamryStructure_EIS_gel3_Day07(jj).Zmag];
    PhaseArray = [PhaseArray gamryStructure_EIS_gel3_Day07(jj).Phase];
end


meanMeanArray = mean(meanArray, 2);
stdMeanArray = std(meanArray, 0, 2);
meanPhaseArray = mean(PhaseArray, 2);
stdPhaseArray = std(PhaseArray, 0, 2);

yyaxis left
errorbar( gamryStructure_EIS_gel2_Day00(1).f, ...
        meanMeanArray, ...
        stdMeanArray, 'LineWidth', 2.0)
hold on
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
xlim([10 1e6])

yyaxis right
errorbar( gamryStructure_EIS_gel2_Day00(1).f, ...
        meanPhaseArray, ...
        stdPhaseArray, 'LineWidth', 2.0)
hold on
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')
xlim([9.9 1e6])
legend('Gel Day 0', 'Gel Day 7', 'CM')
% title('CM vs Gel')

%% UBEC Plot

% GEL Day 0% 
meanArray = [];
PhaseArray = [];
meanMeanArray = [];
stdMeanArray = [];
meanPhaseArray = [];
stdPhaseArray = [];

% 11/24 
pointerArray = [12 24]; 
numMeasures = length(pointerArray);
for ii = 1:numMeasures
    jj = pointerArray(ii);
    meanArray = [meanArray gamryStructure_EIS_gel1_Day00(jj).Zmag];
    PhaseArray = [PhaseArray gamryStructure_EIS_gel1_Day00(jj).Phase];
end

% 12/08 
pointerArray = [6]; % Note, this needs to be fixed in the actual figure
numMeasures = length(pointerArray);
for ii = 1:numMeasures
    jj = pointerArray(ii);
    meanArray = [meanArray gamryStructure_EIS_gel2_Day00(jj).Zmag];
    PhaseArray = [PhaseArray gamryStructure_EIS_gel2_Day00(jj).Phase];
end

meanMeanArray = mean(meanArray, 2);
stdMeanArray = std(meanArray, 0, 2);
meanPhaseArray = mean(PhaseArray, 2);
stdPhaseArray = std(PhaseArray, 0, 2);

figure
errorbar( gamryStructure_EIS_gel2_Day00(1).f, ...
        meanMeanArray, ...
        stdMeanArray, 'LineWidth', 2.0)
hold on
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
% xlim([10 1e5])

% GEL Day 7% 
meanArray = [];
PhaseArray = [];
meanMeanArray = [];
stdMeanArray = [];
meanPhaseArray = [];
stdPhaseArray = [];

% 12/21
pointerArray = [6 9 12]; 
numMeasures = length(pointerArray);
for ii = 1:numMeasures
    jj = pointerArray(ii);
    meanArray = [meanArray gamryStructure_EIS_gel3_Day07(jj).Zmag];
    PhaseArray = [PhaseArray gamryStructure_EIS_gel3_Day07(jj).Phase];
end

meanMeanArray = mean(meanArray, 2);
stdMeanArray = std(meanArray, 0, 2);
meanPhaseArray = mean(PhaseArray, 2);
stdPhaseArray = std(PhaseArray, 0, 2);

errorbar( gamryStructure_EIS_gel3_Day07(1).f, ...
        meanMeanArray, ...
        stdMeanArray, 'LineWidth', 2.0)
hold on
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
% xlim([10 1e5])

% CULTURE MEDIA % 
meanArray = [];
PhaseArray = [];
meanMeanArray = [];
stdMeanArray = [];
meanPhaseArray = [];
stdPhaseArray = [];

% 11/24 
pointerArray = [9]; 
numMeasures = length(pointerArray);
for ii = 1:numMeasures
    jj = pointerArray(ii);
    meanArray = [meanArray gamryStructure_EIS_gel1_Day00(jj).Zmag];
    PhaseArray = [PhaseArray gamryStructure_EIS_gel1_Day00(jj).Phase];
end

% 12/08 
pointerArray = [3]; 
numMeasures = length(pointerArray);
for ii = 1:numMeasures
    jj = pointerArray(ii);
    meanArray = [meanArray gamryStructure_EIS_gel2_Day00(jj).Zmag];
    PhaseArray = [PhaseArray gamryStructure_EIS_gel2_Day00(jj).Phase];
end

% 12/21
pointerArray = [3]; 
numMeasures = length(pointerArray);
for ii = 1:numMeasures
    jj = pointerArray(ii);
    meanArray = [meanArray gamryStructure_EIS_gel3_Day07(jj).Zmag];
    PhaseArray = [PhaseArray gamryStructure_EIS_gel3_Day07(jj).Phase];
end


meanMeanArray = mean(meanArray, 2);
stdMeanArray = std(meanArray, 0, 2);
meanPhaseArray = mean(PhaseArray, 2);
stdPhaseArray = std(PhaseArray, 0, 2);

errorbar( gamryStructure_EIS_gel2_Day00(1).f, ...
        meanMeanArray, ...
        stdMeanArray, 'LineWidth', 2.0)
hold on
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
xlim([10 1e6])
