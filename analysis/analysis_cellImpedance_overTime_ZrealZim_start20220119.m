%% analysis_cellImpedance_overTime_ZrealZim_start20220119
% Looking for changes in impedance across XX days as we try to grow a
% monolayer of astrocytes on 4 gels. Compared to a control well with just
% the culture media used with the astrocytes. This control is measured
% first and last to get an idea of any electrode drift that might be
% happening.
% This is a follow up script to the more general "experiment_" scripts of
% similar name. 

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
% Day 1:    20220212_WPI02_GelCell_Day01
% Day 2:    20220213_WPI02_GelCell_Day02
% Day 3:    20220214_WPI02_GelCell_Day03
% Day 4:    20220215_WPI02_GelCell_Day04
% Day 5:    20220216_WPI02_GelCell_Day05\EIS
% Day 6 Pre CM change: 20220217_WPI02_GelCell_Day06_r1
% Day 6 PostCM change: 20220217_WPI02_GelCell_Day06_r2

[gamryStructure_EIS_cell] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220217_WPI02_GelCell_Day06_r2');    % Change this one to whatever day you want to analyze

% The trend from 2/16 seems to have disappeared. The only things I really
% saw 2/17 seemed to be soaking related (CM_r2 was in line with gel
% measurements). In the post CM measurements, I let the electrodes soak in
% the CM for about 10 minutes before starting any measurements and these
% are much more consistent. There may be a very slight trend in low
% frequency phase that is legitimate. Look into this and review the old
% data with Phillip to see how long of a soak is required to stabilize. 
% Gels and CM are almost identical until Day 05. Then there is some pretty
% noticible change. Let's see if this stays consistent after Day 06. 
%% Individual Measurements
% Day 05 %
figure
yyaxis left
for ii = 1:length(gamryStructure_EIS_cell)
    loglog( gamryStructure_EIS_cell(ii).f, ...
            gamryStructure_EIS_cell(ii).Zmag )
    hold on
end
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')

yyaxis right
for ii = 1:length(gamryStructure_EIS_cell)
    loglog( gamryStructure_EIS_cell(ii).f, ...
            gamryStructure_EIS_cell(ii).Phase )
    hold on
end
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')
xlim([9.9 1e6])
legend('CM-r1', 'CM-r2', 'Gel 01', 'Gel 02', 'Gel 03', 'Gel 04','Gel 05', 'Gel 06')
title('Day 05 - Individual Measurements')


%% Combined plots
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
    meanArray = [meanArray gamryStructure_EIS_cell(jj).Zmag];
    RealArray = [RealArray gamryStructure_EIS_cell(jj).Zreal];
    ImArray = [ImArray gamryStructure_EIS_cell(jj).Zim];
    PhaseArray = [PhaseArray gamryStructure_EIS_cell(jj).Phase];
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
errorbar( gamryStructure_EIS_cell(1).f, ...
        meanMeanArray, ...
        stdMeanArray, 'LineWidth', 2.0)
hold on
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')

yyaxis right
errorbar( gamryStructure_EIS_cell(1).f, ...
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
    meanArray = [meanArray gamryStructure_EIS_cell(jj).Zmag];
    RealArray = [RealArray gamryStructure_EIS_cell(jj).Zreal];
    ImArray = [ImArray gamryStructure_EIS_cell(jj).Zim];
    PhaseArray = [PhaseArray gamryStructure_EIS_cell(jj).Phase];
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
errorbar( gamryStructure_EIS_cell(1).f, ...
        meanMeanArray, ...
        stdMeanArray, 'LineWidth', 1.0)
hold on
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
xlim([10 1e6])

yyaxis right
errorbar( gamryStructure_EIS_cell(1).f, ...
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
errorbar( gamryStructure_EIS_cell(1).f, ...
        allImpMeanArray(:,1), ...
        allImpStdArray(:,1), 'LineWidth', 1.0)
hold on
errorbar( gamryStructure_EIS_cell(1).f, ...
        allImpMeanArray(:,3), ...
        allImpStdArray(:,3), 'LineWidth', 1.0)
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
xlim([10 1e6])
legend('Gels', 'CM')
title('Day 05 Zreal')

% %Change
ZrealChange = ((allImpMeanArray(:,1) - allImpMeanArray(:,3))./allImpMeanArray(:,3))*100;
figure
semilogx( gamryStructure_EIS_cell(1).f, ...
          ZrealChange, ...
         'LineWidth', 1.0)
xlabel('Frequency (Hz)')
ylabel('% Zreal Change')
xlim([10 1e6])
title('Day 05 Zreal % Difference')
ZrealChangeAvg = mean(abs(ZrealChange))

% ZIm % 
figure
errorbar( gamryStructure_EIS_cell(1).f, ...
        -1*allImpMeanArray(:,2), ...
        allImpStdArray(:,2), 'LineWidth', 1.0)
hold on
errorbar( gamryStructure_EIS_cell(1).f, ...
        -1*allImpMeanArray(:,4), ...
        allImpStdArray(:,4), 'LineWidth', 1.0)
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
xlim([10 1e6])
legend('Gels', 'CM')
title('Day 05')

% %Change
ZimChange = ((allImpMeanArray(:,2) - allImpMeanArray(:,4))./allImpMeanArray(:,4))*100;
figure
semilogx( gamryStructure_EIS_cell(1).f, ...
          ZimChange, ...
         'LineWidth', 1.0)
xlabel('Frequency (Hz)')
ylabel('% Zim Change')
xlim([10 1e6])
title('Day 05 ZIm % Difference')
ZimChangeAvg = mean(abs(ZimChange))