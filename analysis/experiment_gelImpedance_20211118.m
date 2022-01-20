%% experiment_gelImpedance_20211118
% Quick comparison of the impedance/CV of two gels using WPI02.  

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
[gamryStructure_CV_PBS] = ...
    extractCVData('..\rawData\Gamry\20211116_WPI01_03_InVitro_Gib1xPBS\CV');
[gamryStructure_EIS_PBS] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20211116_WPI01_03_InVitro_Gib1xPBS\EIS');
[gamryStructure_CV_gel] = ...
    extractCVData('..\rawData\Gamry\20211118_WPI02_InVitro_GelCM\CV');
[gamryStructure_EIS_gel] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20211118_WPI02_InVitro_GelCM\EIS');

%% CV quick
figure
colorArray = lines(9);
for ii = 4
    for jj = 3
        scatter( gamryStructure_CV_PBS(ii).potential{jj}, ...
                 gamryStructure_CV_PBS(ii).current{jj}, [], '.')
        hold on
    end
end

for ii = 1:4
    for jj = 5
        scatter( gamryStructure_CV_gel(ii).potential{jj}, ...
                 gamryStructure_CV_gel(ii).current{jj}, [], '.')
        hold on
    end
end
legend('PBS', 'cultureMedia r1', 'cultureMedia r2', 'gel01', 'gel02')

%%
% See lower amplitude oxidation peaks for both of the gels. 
%% Impedance and phase 
figure
colorArray = lines(8);
for ii = 2
    yyaxis left
    loglog( gamryStructure_EIS_PBS(ii).f, ...
            gamryStructure_EIS_PBS(ii).Zmag, ...
            'Color', colorArray( ii, : ))
    hold on
end
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
for ii = 1:5
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

% Phase
for ii = 2
    yyaxis right
    semilogx( gamryStructure_EIS_PBS(ii).f, ...
            gamryStructure_EIS_PBS(ii).Phase, ...
            'o','Color', colorArray( ii, : ))
    ylabel('Phase')
    hold on
end
for ii = 1:5
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
legend('PBS', 'cultureMedia r1', 'cultureMedia r2', 'gel01', 'gel02', 'gel02 penetrated')

%% 
% Impedance looks very consistent between electrodes. Good news!

%% Nyquist % NEED TO VERIFY THESE AVERAGES ARE CORRECT, LIKELY OFF SLIGHTLY 20211203
% Calculate means/std
figure
[~, numMeasures] = size(gamryStructure_EIS_gel);
meanArray = [];
meanPhaseArray = [];
jj = 1;
for ii = 1:numMeasures
    meanArray = [meanArray gamryStructure_EIS_gel(ii).Zreal];
    meanPhaseArray = [meanPhaseArray gamryStructure_EIS_gel(ii).Zim];
    if mod(ii,3) == 0
        meanMeanArray(:,jj) = mean(meanArray, 2);
        stdMeanArray(:,jj) = std(meanArray, 0, 2);
        meanPhaseArray(:,jj) = mean(meanPhaseArray, 2);
        stdPhaseArray(:,jj) = std(meanPhaseArray, 0, 2);
        jj = jj + 1;
    end
end
for ii = 2
    plot( gamryStructure_EIS_PBS(ii).Zreal, ...
            -1*gamryStructure_EIS_PBS(ii).Zim, '-o')
    hold on
end
for ii = 1:5
    plot( meanArray(:,ii), ...
            -1*meanPhaseArray(:,ii), '-o')
    hold on
end
legend('PBS', 'cultureMedia r1', 'cultureMedia r2', 'gel01', 'gel02', 'gel02 penetrated')

%% 
% In presentation, include a plot of the in vivo data (day 0) I used in
% proposal and make the point we haven't recreated the "tissue component"
% entirely.