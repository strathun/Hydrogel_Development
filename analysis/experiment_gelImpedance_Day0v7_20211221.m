%% experiment_gelImpedance_Day0v7_20211221
% Comparing day 0 impedance of the gels to day 07.    

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
% [gamryStructure_CV_gel] = ...
%     extractCVData('..\rawData\Gamry\20211123_WPI02_InVitro_GelCM\CV');
[gamryStructure_EIS_gel1_Day00] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20211123_WPI02_InVitro_GelCM\EIS');
[gamryStructure_EIS_gel2_Day00] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20211208_WPI02_InVitro_GelCM\EIS');
[gamryStructure_EIS_gel3_Day07] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20211221_WPI02_InVitro_GelCM\EIS');

%% CV quick
% figure
% for ii = 1:3
%     for jj = 3
%         scatter( gamryStructure_CV_gel(ii).potential{jj}, ...
%                  gamryStructure_CV_gel(ii).current{jj}*1e6, [], '.')
%         hold on
%     end
% end
% xlabel('Voltage (V)')
% ylabel('Current (uA)')
% legend('cultureMedia', 'gel01', 'gel02')


%%
% See lower amplitude oxidation peaks for both of the gels. 

%% Impedance and phase 11/23
% Calculate means/std
[~, numMeasures] = size(gamryStructure_EIS_gel1_Day00);
meanArray = [];
PhaseArray = [];
jj = 1;
for ii = 1:numMeasures
    meanArray = [meanArray gamryStructure_EIS_gel1_Day00(ii).Zmag];
    PhaseArray = [PhaseArray gamryStructure_EIS_gel1_Day00(ii).Phase];
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

% Culture Media vs Gel
% 3e all
figure
pointerArray = [3 4 8];
for ii = 1:3
    jj = pointerArray(ii);
    yyaxis left
    errorbar( gamryStructure_EIS_gel1_Day00(1).f, ...
            meanMeanArray(:,jj), ...
            stdMeanArray(:,jj))
    hold on
end
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
% xlim([10 1e5])

for ii = 1:3
    jj = pointerArray(ii);
    yyaxis right
    errorbar( gamryStructure_EIS_gel1_Day00(1).f, ...
            meanPhaseArray(:,jj), ...
            stdPhaseArray(:,jj))
    hold on
end
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')
% xlim([10 1e5])
% legend('culture Media', 'Gel 1', 'Gel 2')
title('CM vs Gel')

%% Impedance and phase 12/08
% Calculate means/std
[~, numMeasures] = size(gamryStructure_EIS_gel2_Day00);
meanArray = [];
PhaseArray = [];
meanMeanArray = [];
stdMeanArray = [];
meanPhaseArray = [];
stdPhaseArray = [];
jj = 1;
for ii = 1:numMeasures
    meanArray = [meanArray gamryStructure_EIS_gel2_Day00(ii).Zmag];
    PhaseArray = [PhaseArray gamryStructure_EIS_gel2_Day00(ii).Phase];
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

% Culture Media vs Gel
% 3e all
pointerArray = [1 2 3];
for ii = 1:3
    jj = pointerArray(ii);
    yyaxis left
    errorbar( gamryStructure_EIS_gel2_Day00(1).f, ...
            meanMeanArray(:,jj), ...
            stdMeanArray(:,jj))
    hold on
end
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
% xlim([10 1e5])

for ii = 1:3
    jj = pointerArray(ii);
    yyaxis right
    errorbar( gamryStructure_EIS_gel2_Day00(1).f, ...
            meanPhaseArray(:,jj), ...
            stdPhaseArray(:,jj))
    hold on
end
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')
% xlim([10 1e5])
legend('culture Media', 'Gel 1', 'Gel 2', 'Culture Media 2', 'Gel 3', 'Gel 4')
title('CM vs Gel')

%% 
% Trend between Cm and Gel from 11/24 data does not seem to have been
% preserved on 12/08. Makes it so there is very little difference between
% gel and cm when averaging all of the data points for the two conditions 
% (see below). 

%% Impedance and phase 12/21
% Calculate means/std
[~, numMeasures] = size(gamryStructure_EIS_gel3_Day07);
meanArray = [];
PhaseArray = [];
meanMeanArray = [];
stdMeanArray = [];
meanPhaseArray = [];
stdPhaseArray = [];
jj = 1;
for ii = 1:numMeasures
    meanArray = [meanArray gamryStructure_EIS_gel3_Day07(ii).Zmag];
    PhaseArray = [PhaseArray gamryStructure_EIS_gel3_Day07(ii).Phase];
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

% Impedance
pointerArray = [1 2 3 4];
for ii = 1:4
    jj = pointerArray(ii);
    yyaxis left
    errorbar( gamryStructure_EIS_gel3_Day07(1).f, ...
            meanMeanArray(:,jj), ...
            stdMeanArray(:,jj))
    hold on
end
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
% xlim([10 1e5])

% Phase
for ii = 1:4
    jj = pointerArray(ii);
    yyaxis right
    errorbar( gamryStructure_EIS_gel3_Day07(1).f, ...
            meanPhaseArray(:,jj), ...
            stdPhaseArray(:,jj))
    hold on
end
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')
% xlim([10 1e5])
legend('culture Media', 'Gel 1', 'Gel 2', 'Culture Media 2', 'Gel 3', 'Gel 4', 'Culture Media 3', 'Gel 5', 'Gel 6', 'Gel 7')
title('CM vs Gel')


%% Impedance and phase 11/24 and 12/08 combined averages with Day 07 (12/21)

% GEL Day 0% 
meanArray = [];
PhaseArray = [];
meanMeanArray = [];
stdMeanArray = [];
meanPhaseArray = [];
stdPhaseArray = [];

% 11/24 
pointerArray = [10 11 12 22 23 24]; 
numMeasures = length(pointerArray);
for ii = 1:numMeasures
    jj = pointerArray(ii);
    meanArray = [meanArray gamryStructure_EIS_gel1_Day00(jj).Zmag];
    PhaseArray = [PhaseArray gamryStructure_EIS_gel1_Day00(jj).Phase];
end

% 12/08 
pointerArray = [4 5 6 7 8 9]; 
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
        stdMeanArray)
hold on
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
% xlim([10 1e5])

yyaxis right
errorbar( gamryStructure_EIS_gel2_Day00(1).f, ...
        meanPhaseArray, ...
        stdPhaseArray)
hold on
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')
% xlim([10 1e5])

% GEL Day 7% 
meanArray = [];
PhaseArray = [];
meanMeanArray = [];
stdMeanArray = [];
meanPhaseArray = [];
stdPhaseArray = [];

% 12/21
pointerArray = [4 5 6 7 8 9 10 11 12]; 
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
        stdMeanArray)
hold on
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
% xlim([10 1e5])

yyaxis right
errorbar( gamryStructure_EIS_gel3_Day07(1).f, ...
        meanPhaseArray, ...
        stdPhaseArray)
hold on
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')
% xlim([10 1e5])

% CULTURE MEDIA % 
meanArray = [];
PhaseArray = [];
meanMeanArray = [];
stdMeanArray = [];
meanPhaseArray = [];
stdPhaseArray = [];

% 11/24 
pointerArray = [7 8 9]; 
numMeasures = length(pointerArray);
for ii = 1:numMeasures
    jj = pointerArray(ii);
    meanArray = [meanArray gamryStructure_EIS_gel1_Day00(jj).Zmag];
    PhaseArray = [PhaseArray gamryStructure_EIS_gel1_Day00(jj).Phase];
end

% 12/08 
pointerArray = [1 2 3]; 
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

yyaxis left
errorbar( gamryStructure_EIS_gel2_Day00(1).f, ...
        meanMeanArray, ...
        stdMeanArray)
hold on
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
xlim([10 1e6])

yyaxis right
errorbar( gamryStructure_EIS_gel2_Day00(1).f, ...
        meanPhaseArray, ...
        stdPhaseArray)
hold on
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')
xlim([10 1e6])
legend('Gel Day 0', 'Gel Day 7', 'CM')
title('CM vs Gel')

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
% pointerArray = [6 9]; 
pointerArray = [6]; 
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
xlim([9.9 1e6]) % Do 9.9 to make sure error bars plot
% legend('Gel Day 0', 'Gel Day 7', 'CM')
% title('CM vs Gel')

%% Nyquist fixed
% Calculate means/std
[~, numMeasures] = size(gamryStructure_EIS_gel1_Day00);
meanArray = [];
PhaseArray = [];
jj = 1;
for ii = 1:numMeasures
    meanArray = [meanArray gamryStructure_EIS_gel1_Day00(ii).Zreal];
    PhaseArray = [PhaseArray gamryStructure_EIS_gel1_Day00(ii).Zim];
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

%% 
figure
pointerArray = [3 4 8];
for ii = 1:3
    jj = pointerArray(ii);
    plot( meanMeanArray(:,jj)./1000, ...
            -1*meanPhaseArray(:,jj)./1000, '-o')
    hold on
end
legend('CultureMedia', 'Gel 1', 'Gel 2')
xlabel('Real(Imp) (kOhm)')
ylabel('-Imag(Imp) (kOhm)')

%% loglog
figure
pointerArray = [3 4 8];
for ii = 1:3
    jj = pointerArray(ii);
    plot( meanMeanArray(:,jj), ...
            -1*meanPhaseArray(:,jj), '-o')
    hold on
end
set(gca,'XScale','log','YScale','log')
legend('CultureMedia', 'Gel 1', 'Gel 2')
xlim([20^2 10^5])
xlabel('Real(Imp) (kOhm)')
ylabel('-Imag(Imp) (kOhm)')
%% Compare to in vivo
load('..\rawData\Gamry\20180507_TDT6_Surgery\avgImpStructure.mat')
% figure
% pointerArray = [3 4 8];
% for ii = 1:3
%     jj = pointerArray(ii);
%     plot( meanMeanArray(:,jj)./1000, ...
%             -1*meanPhaseArray(:,jj)./1000, '-o')
%     hold on
% end

figure
for jj = 1:1
    plot( avgImpStructure(1).avgImp_Real./1000, ...
              (-1)*avgImpStructure(1).avgImp_Imag./1000, '-o','Color', 'k');
        hold on
%     plot( avgImpStructure(2).avgImp_Real./1000, ...
%               (-1)*avgImpStructure(2).avgImp_Imag./1000, '-*', 'Color', 'k');
end
% set(gca,'XScale','log','YScale','log')   % Note: Plotting this on a loglog plot looks cool as shit. Consider doing this at some point 
xlabel('Real(Imp) (kOhm)')
ylabel('-Imag(Imp) (kOhm)')

% xlim([1 1e2])
% ylim([1 0.7e2])
%% Single Tester
% figure
% for ii = 1:3
%     yyaxis left
%     loglog(gamryStructure_EIS_gel(ii).f, gamryStructure_EIS_gel(ii).Zmag)
%     hold on
%     yyaxis right
%     loglog(gamryStructure_EIS_gel(ii).f, gamryStructure_EIS_gel(ii).Phase)
% end
%% 
% In presentation, include a plot of the in vivo data (day 0) I used in
% proposal and make the point we haven't recreated the "tissue component"
% entirely.