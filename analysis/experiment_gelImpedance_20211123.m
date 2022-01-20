%% experiment_gelImpedance_20211123
% Comparison of the impedance/CV of two gels using WPI02.  

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
[gamryStructure_CV_gel] = ...
    extractCVData('..\rawData\Gamry\20211123_WPI02_InVitro_GelCM\CV');
[gamryStructure_EIS_gel] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20211123_WPI02_InVitro_GelCM\EIS');

%% CV quick
figure
for ii = 1:3
    for jj = 3
        scatter( gamryStructure_CV_gel(ii).potential{jj}, ...
                 gamryStructure_CV_gel(ii).current{jj}*1e6, [], '.')
        hold on
    end
end
xlabel('Voltage (V)')
ylabel('Current (uA)')
legend('cultureMedia', 'gel01', 'gel02')


%%
% See lower amplitude oxidation peaks for both of the gels. 

%% Impedance and phase 
% Calculate means/std
[~, numMeasures] = size(gamryStructure_EIS_gel);
meanArray = [];
PhaseArray = [];
jj = 1;
for ii = 1:numMeasures
    meanArray = [meanArray gamryStructure_EIS_gel(ii).Zmag];
    PhaseArray = [PhaseArray gamryStructure_EIS_gel(ii).Phase];
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
% Culture Media
figure
for ii = 1:3
    yyaxis left
    errorbar( gamryStructure_EIS_gel(1).f, ...
            meanMeanArray(:,ii), ...
            stdMeanArray(:,ii))
    hold on
end
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
xlim([10 1e5])

for ii = 1:3
    yyaxis right
    errorbar( gamryStructure_EIS_gel(1).f, ...
            meanPhaseArray(:,ii), ...
            stdPhaseArray(:,ii))
    hold on
end
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
xlim([10 1e5])
legend('2e-WPI', '2e-Pt', '3e')
title('Culture Media')

% Gel 1
figure
for ii = 4:7
    yyaxis left
    errorbar( gamryStructure_EIS_gel(1).f, ...
            meanMeanArray(:,ii), ...
            stdMeanArray(:,ii))
    hold on
end
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
xlim([10 1e5])

for ii = 4:7
    yyaxis right
    errorbar( gamryStructure_EIS_gel(1).f, ...
            meanPhaseArray(:,ii), ...
            stdPhaseArray(:,ii))
    hold on
end
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
xlim([10 1e5])
legend('3e', '2e-Pt', '2e-Pt, Pen.', '2e-WPI')
title('Gel 1')

% Gel 2
figure
for ii = 8:10
    yyaxis left
    errorbar( gamryStructure_EIS_gel(1).f, ...
            meanMeanArray(:,ii), ...
            stdMeanArray(:,ii))
    hold on
end
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
xlim([10 1e5])

for ii = 8:10
    yyaxis right
    errorbar( gamryStructure_EIS_gel(1).f, ...
            meanPhaseArray(:,ii), ...
            stdPhaseArray(:,ii))
    hold on
end
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
xlim([10 1e5])
legend('3e', '2e-Pt', '2e-WPI')
title('Gel 2')

%%
% Main differences come from using the WPI electrode as the counter

%% Culture Media vs Gel
% 3e all
figure
pointerArray = [3 4 8];
for ii = 1:3
    jj = pointerArray(ii);
    yyaxis left
    errorbar( gamryStructure_EIS_gel(1).f, ...
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
    errorbar( gamryStructure_EIS_gel(1).f, ...
            meanPhaseArray(:,jj), ...
            stdPhaseArray(:,jj))
    hold on
end
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')
% xlim([10 1e5])
legend('culture Media', 'Gel 1', 'Gel 2')
title('CM vs Gel')

%%
% Slight difference in the Phase, but impedance is almost identical

%% 2e vs 3e gel
% Want to see if lack of difference comes from 2e vs 3e. Pt only
figure
pointerArray = [4 5 8 9];
for ii = 1:4
    jj = pointerArray(ii);
    yyaxis left
    errorbar( gamryStructure_EIS_gel(1).f, ...
            meanMeanArray(:,jj), ...
            stdMeanArray(:,jj))
    hold on
end
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
xlim([10 1e5])

for ii = 1:4
    jj = pointerArray(ii);
    yyaxis right
    errorbar( gamryStructure_EIS_gel(1).f, ...
            meanPhaseArray(:,jj), ...
            stdPhaseArray(:,jj))
    hold on
end
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
xlim([10 1e5])
legend('Gel 1 - 3e', 'Gel 1 - 2e', 'Gel 2 - 3e', 'Gel 2 - 2e')
title('2e vs 3e gel')

%% 
% Is a difference here, and the 2e has a greater phase shift meaning that
% it will have a larger difference compared to CM. Wasn't true, because CM
% phase also dropped for the 2e measurement

%% CM vs Gel (2e)
figure
pointerArray = [2 5 9];
for ii = 1:3
    jj = pointerArray(ii);
    yyaxis left
    errorbar( gamryStructure_EIS_gel(1).f, ...
            meanMeanArray(:,jj), ...
            stdMeanArray(:,jj))
    hold on
end
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
xlim([10 1e5])

for ii = 1:3
    jj = pointerArray(ii);
    yyaxis right
    errorbar( gamryStructure_EIS_gel(1).f, ...
            meanPhaseArray(:,jj), ...
            stdPhaseArray(:,jj))
    hold on
end
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
xlim([10 1e5])
legend('culture Media', 'Gel 1', 'Gel 2')
title('Gel Vs CM - 2e')

%%
% Phase shift for 2e CM drops too, so actually less of a difference

%% Nyquist fixed
% Calculate means/std
[~, numMeasures] = size(gamryStructure_EIS_gel);
meanArray = [];
PhaseArray = [];
jj = 1;
for ii = 1:numMeasures
    meanArray = [meanArray gamryStructure_EIS_gel(ii).Zreal];
    PhaseArray = [PhaseArray gamryStructure_EIS_gel(ii).Zim];
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
%% Compare to in vitro
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