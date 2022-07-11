%% experiment_insertInsulation_overTime_start20220621
% Testing to see if the new double chamber inserts remain electrochemically
% insulated across 2 weeks. Comparing to commercial transell inserts. All
% are superglued to the bottom of a 12 well plate. 
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
    extractImpedanceDataGlobal('..\rawData\Gamry\20220505_WPI03_Insert_insulation_Day00');
[gamryStructure_EIS_cell_Day02] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220510_WPI03_Insert_insulation_Day05');
[gamryStructure_EIS_cell_Day03] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220512_WPI03_Insert_insulation_Day07');
[gamryStructure_EIS_cell_Day04] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220517_WPI03_Insert_insulation_Day12');
[gamryStructure_EIS_cell_Day05] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220519_WPI03_Insert_insulation_Day14');
[gamryStructure_EIS_cell_Day06] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220523_WPI03_Insert_insulation');
[gamryStructure_EIS_TDT_InVivo] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\2018-03-20_TDT5_Day19\Impedance');
% Second example to see if above is within typical in vivo range. 
% [gamryStructure_EIS_TDT_InVivo] = ...
%     extractImpedanceDataGlobal('..\rawData\Gamry\2019-07-30_TDT19_Day11\Impedance');
[gamryStructure_EIS_Open] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220428_WPI03_Insert_insulation');
% Round 2
[gamryStructure_EIS_cell_Day01_r2] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220621_WPI03_Insert_insulation_Day00');
[gamryStructure_EIS_cell_Day02_r2] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220623_WPI03_Insert_insulation_Day02');
[gamryStructure_EIS_cell_Day03_r2] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220628_WPI03_Insert_insulation_Day07');
[gamryStructure_EIS_cell_Day04_r2] = ...
    extractImpedanceDataGlobal('..\rawData\Gamry\20220705_WPI03_Insert_insulation_Day14');

%% Individual Measurement Plots
%%% Day 00 %%%
% Impedance 
figure
[~, numRuns] = size(gamryStructure_EIS_cell_Day01);
colorArray = lines(numRuns);
for ii = 1:6
    if ii < 4
        x = gamryStructure_EIS_cell_Day01_r2(ii).f;
        y = gamryStructure_EIS_cell_Day01_r2(ii).Zmag;
    else
        x = gamryStructure_EIS_cell_Day01(ii).f;
        y = gamryStructure_EIS_cell_Day01(ii).Zmag;
    end
    
    scatter( x, y, [], colorArray( ii, : ))
    hold on
    fit_vals = polyfit(log(x(1:end-20)), log(y(1:end-20)), 1);
    fit_line = polyval(fit_vals, log(x(1:end-20)));
    plot( x(1:end-20), exp(fit_line) , 'LineWidth', 1.5,...
          'Color', colorArray( ii, : ))
end
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
xlim([9.9 1e6])
legend( 'Print01', '', 'Print02', '', 'Print03', '', ...
        'Twell01', '', 'Twell02', '', 'Twell03', '')
title('Day 00 - Individual Measurements - Impedance')

% Phase
figure
for ii = 1:6
    if ii < 4
        x = gamryStructure_EIS_cell_Day01_r2(ii).f;
        y = gamryStructure_EIS_cell_Day01_r2(ii).Phase;
    else
        x = gamryStructure_EIS_cell_Day01(ii).f;
        y = gamryStructure_EIS_cell_Day01(ii).Phase;
    end
    scatter( x, y, [], colorArray( ii, : ))
    hold on
end
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')
xlim([9.9 1e6])
title('Phase')
legend( 'Print01', 'Print02', 'Print03', 'Twell01', 'Twell02', 'Twell03')
title('Day 00 - Individual Measurements - Phase')

%%% Day 02 & 05 %%%
% Impedance
figure
[~, numRuns] = size(gamryStructure_EIS_cell_Day01);
colorArray = lines(numRuns);
for ii = 1:6
    if ii < 4
        x = gamryStructure_EIS_cell_Day02_r2(ii).f;
        y = gamryStructure_EIS_cell_Day02_r2(ii).Zmag;
    else
        x = gamryStructure_EIS_cell_Day02(ii).f;
        y = gamryStructure_EIS_cell_Day02(ii).Zmag;
    end
    
    scatter( x, y, [], colorArray( ii, : ))
    hold on
    fit_vals = polyfit(log(x(1:end-20)), log(y(1:end-20)), 1);
    fit_line = polyval(fit_vals, log(x(1:end-20)));
    plot( x(1:end-20), exp(fit_line) , 'LineWidth', 1.5,...
          'Color', colorArray( ii, : ))
end
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
xlim([9.9 1e6])
legend( 'Print01', '', 'Print02', '', 'Print03', '', ...
        'Twell01', '', 'Twell02', '', 'Twell03', '')
title('Day 02 - Individual Measurements - Impedance')

% Phase
figure
for ii = 1:6
    if ii < 4
        x = gamryStructure_EIS_cell_Day02_r2(ii).f;
        y = gamryStructure_EIS_cell_Day02_r2(ii).Phase;
    else
        x = gamryStructure_EIS_cell_Day02(ii).f;
        y = gamryStructure_EIS_cell_Day02(ii).Phase;
    end
    scatter( x, y, [], colorArray( ii, : ))
    hold on
end
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')
xlim([9.9 1e6])
title('Phase')
legend( 'Print01', 'Print02', 'Print03', 'Twell01', 'Twell02', 'Twell03')
title('Day 02 - Individual Measurements - Phase')

%%% Day 07 %%%
% Impedance
figure
[~, numRuns] = size(gamryStructure_EIS_cell_Day01);
colorArray = lines(numRuns);
for ii = 1:6
    if ii < 4
        x = gamryStructure_EIS_cell_Day03_r2(ii+1).f;
        y = gamryStructure_EIS_cell_Day03_r2(ii+1).Zmag;
    else
        x = gamryStructure_EIS_cell_Day03(ii).f;
        y = gamryStructure_EIS_cell_Day03(ii).Zmag;
    end
    
    scatter( x, y, [], colorArray( ii, : ))
    hold on
    fit_vals = polyfit(log(x(1:end-20)), log(y(1:end-20)), 1);
    fit_line = polyval(fit_vals, log(x(1:end-20)));
    plot( x(1:end-20), exp(fit_line) , 'LineWidth', 1.5,...
          'Color', colorArray( ii, : ))
end
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
xlim([9.9 1e6])
legend( 'Print01', '', 'Print02', '', 'Print03', '', ...
        'Twell01', '', 'Twell02', '', 'Twell03', '')
title('Day 07 - Individual Measurements - Impedance')

% Phase
figure
for ii = 1:6
    if ii < 4
        x = gamryStructure_EIS_cell_Day03_r2(ii+1).f;
        y = gamryStructure_EIS_cell_Day03_r2(ii+1).Phase;
    else
        x = gamryStructure_EIS_cell_Day03(ii).f;
        y = gamryStructure_EIS_cell_Day03(ii).Phase;
    end
    scatter( x, y, [], colorArray( ii, : ))
    hold on
end
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')
xlim([9.9 1e6])
title('Phase')
legend( 'Print01', 'Print02', 'Print03', 'Twell01', 'Twell02', 'Twell03')
title('Day 07 - Individual Measurements - Phase')

%%% Day 14 %%%
% Impedance
figure
[~, numRuns] = size(gamryStructure_EIS_cell_Day01);
colorArray = lines(numRuns);
for ii = 1:6
    if ii < 4
        x = gamryStructure_EIS_cell_Day04_r2(ii+1).f;
        y = gamryStructure_EIS_cell_Day04_r2(ii+1).Zmag;
    else
        x = gamryStructure_EIS_cell_Day05(ii+1).f;
        y = gamryStructure_EIS_cell_Day05(ii+1).Zmag;
    end
    
    scatter( x, y, [], colorArray( ii, : ))
    hold on
    fit_vals = polyfit(log(x(1:end-20)), log(y(1:end-20)), 1);
    fit_line = polyval(fit_vals, log(x(1:end-20)));
    plot( x(1:end-20), exp(fit_line) , 'LineWidth', 1.5,...
          'Color', colorArray( ii, : ))
end
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
xlim([9.9 1e6])
legend( 'Print01', '', 'Print02', '', 'Print03', '', ...
        'Twell01', '', 'Twell02', '', 'Twell03', '')
title('Day 14 - Individual Measurements - Impedance')

% Phase
figure
for ii = 1:6
    if ii < 4
        x = gamryStructure_EIS_cell_Day04_r2(ii+1).f;
        y = gamryStructure_EIS_cell_Day04_r2(ii+1).Phase;
    else
        x = gamryStructure_EIS_cell_Day05(ii+1).f;
        y = gamryStructure_EIS_cell_Day05(ii+1).Phase;
    end
    scatter( x, y, [], colorArray( ii, : ))
    hold on
end
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')
xlim([9.9 1e6])
title('Phase')
legend( 'Print01', 'Print02', 'Print03', 'Twell01', 'Twell02', 'Twell03')
title('Day 05 - Individual Measurements - Phase')
%% Individual Plots Over time (Twells)
[~, numRuns] = size(gamryStructure_EIS_cell_Day01);
colorArray = lines(5);

% Day 0
for ii = 4:6
    figure(ii+100)
    % Day 00
    x = gamryStructure_EIS_cell_Day01(ii).f;
    y = gamryStructure_EIS_cell_Day01(ii).Zmag;
    scatter( x, y, [], colorArray( 1, : ))
    hold on
    fit_vals = polyfit(log(x(1:end-20)), log(y(1:end-20)), 1);
    fit_line = polyval(fit_vals, log(x(1:end-20)));
    plot( x(1:end-20), exp(fit_line) , 'LineWidth', 1.5,...
          'Color', colorArray( 1, : ))
      
    % Day 05
    x = gamryStructure_EIS_cell_Day02(ii).f;
    y = gamryStructure_EIS_cell_Day02(ii).Zmag;
    scatter( x, y, [], colorArray( 2, : ))
    hold on
    fit_vals = polyfit(log(x(1:end-20)), log(y(1:end-20)), 1);
    fit_line = polyval(fit_vals, log(x(1:end-20)));
    plot( x(1:end-20), exp(fit_line) , 'LineWidth', 1.5,...
          'Color', colorArray( 2, : ))
      
    % Day 07
    x = gamryStructure_EIS_cell_Day03(ii).f;
    y = gamryStructure_EIS_cell_Day03(ii).Zmag;
    scatter( x, y, [], colorArray( 3, : ))
    hold on
    fit_vals = polyfit(log(x(1:end-20)), log(y(1:end-20)), 1);
    fit_line = polyval(fit_vals, log(x(1:end-20)));
    plot( x(1:end-20), exp(fit_line) , 'LineWidth', 1.5,...
          'Color', colorArray( 3, : ))
    
    % Day 12
    plot_array = [1 2 3 5 6 7];
    kk = plot_array(ii);
    x = gamryStructure_EIS_cell_Day04(kk).f;
    y = gamryStructure_EIS_cell_Day04(kk).Zmag;
    scatter( x, y, [], colorArray( 4, : ))
    hold on
    fit_vals = polyfit(log(x(1:end-20)), log(y(1:end-20)), 1);
    fit_line = polyval(fit_vals, log(x(1:end-20)));
    plot( x(1:end-20), exp(fit_line) , 'LineWidth', 1.5,...
          'Color', colorArray( 4, : ))

    % Day 14
    plot_array = [1 2 3 5 6 7];
    kk = plot_array(ii);
    x = gamryStructure_EIS_cell_Day05(kk).f;
    y = gamryStructure_EIS_cell_Day05(kk).Zmag;
    scatter( x, y, [], colorArray( 5, : ))
    hold on
    fit_vals = polyfit(log(x(1:end-20)), log(y(1:end-20)), 1);
    fit_line = polyval(fit_vals, log(x(1:end-20)));
    plot( x(1:end-20), exp(fit_line) , 'LineWidth', 1.5,...
          'Color', colorArray( 5, : ))
    
    set(gca, 'YScale', 'log')
    set(gca, 'XScale', 'log')
    xlabel('Frequency (Hz)')
    ylabel('mag(Impedance) (Ohm)')
    xlim([9.9 1e6])
    legend( 'Day 00', '', 'Day 05', '', 'Day 07', '', 'Day 12', '', 'Day 14', '')
end

%% Individual Plots Over time Prints_r2
colorArray = lines(5);

for ii = 1:3
    figure(ii+100)
    % Day 00
    x = gamryStructure_EIS_cell_Day01_r2(ii).f;
    y = gamryStructure_EIS_cell_Day01_r2(ii).Zmag;
    scatter( x, y, [], colorArray( 1, : ))
    hold on
    fit_vals = polyfit(log(x(1:end-20)), log(y(1:end-20)), 1);
    fit_line = polyval(fit_vals, log(x(1:end-20)));
    plot( x(1:end-20), exp(fit_line) , 'LineWidth', 1.5,...
          'Color', colorArray( 1, : ))
      
    % Day 02
    x = gamryStructure_EIS_cell_Day02_r2(ii).f;
    y = gamryStructure_EIS_cell_Day02_r2(ii).Zmag;
    scatter( x, y, [], colorArray( 2, : ))
    hold on
    fit_vals = polyfit(log(x(1:end-20)), log(y(1:end-20)), 1);
    fit_line = polyval(fit_vals, log(x(1:end-20)));
    plot( x(1:end-20), exp(fit_line) , 'LineWidth', 1.5,...
          'Color', colorArray( 2, : ))
    
    % Day 07
    x = gamryStructure_EIS_cell_Day03_r2(ii+1).f;
    y = gamryStructure_EIS_cell_Day03_r2(ii+1).Zmag;
    scatter( x, y, [], colorArray( 3, : ))
    hold on
    fit_vals = polyfit(log(x(1:end-20)), log(y(1:end-20)), 1);
    fit_line = polyval(fit_vals, log(x(1:end-20)));
    plot( x(1:end-20), exp(fit_line) , 'LineWidth', 1.5,...
          'Color', colorArray( 3, : ))

    % Day 14
    x = gamryStructure_EIS_cell_Day04_r2(ii+1).f;
    y = gamryStructure_EIS_cell_Day04_r2(ii+1).Zmag;
    scatter( x, y, [], colorArray( 4, : ))
    hold on
    fit_vals = polyfit(log(x(1:end-20)), log(y(1:end-20)), 1);
    fit_line = polyval(fit_vals, log(x(1:end-20)));
    plot( x(1:end-20), exp(fit_line) , 'LineWidth', 1.5,...
          'Color', colorArray( 4, : ))
    
    set(gca, 'YScale', 'log')
    set(gca, 'XScale', 'log')
    xlabel('Frequency (Hz)')
    ylabel('mag(Impedance) (Ohm)')
    xlim([9.9 1e6])
    legend( 'Day 00', '', 'Day 02', '', 'Day 07', '', 'Day 14', '')
end

%% Nyquist plots
figure
for ii = 4:4
    x = abs(gamryStructure_EIS_cell_Day01(ii).Zreal);
    y = abs(gamryStructure_EIS_cell_Day01(ii).Zim);
    x = x(1:31);
    y = y(1:31);
    plot( x, y, '-o')
    hold on
end
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')

%% Impedance Real vs Imaginary
figure
for ii = 4:4
    x = abs(gamryStructure_EIS_cell_Day01(ii).f);
    y = abs(gamryStructure_EIS_cell_Day01(ii).Zreal);
    x = x(1:31);
    y = y(1:31);
    plot( x, y, '-o')
    hold on
end
for ii = 4:4
    x = abs(gamryStructure_EIS_cell_Day01(ii).f);
    y = abs(gamryStructure_EIS_cell_Day01(ii).Zim);
    x = x(1:31);
    y = y(1:31);
    plot( x, y, '-o')
    hold on
end
for ii = 4:4
    x = abs(gamryStructure_EIS_cell_Day01(ii).f);
    y = abs(gamryStructure_EIS_cell_Day01(ii).Zmag);
    x = x(1:31);
    y = y(1:31);
    plot( x, y, '-o')
    hold on
end
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
legend('Zreal', 'Zim', 'Zmag')

% Looks like the impedance is mostly imaginary impedance, which makes
% sense, because the measurement is basically a capacitor. 
%% Comparison of print, transwell, and open lead
% figure
% % Print wall
% x = gamryStructure_EIS_cell_Day01(1).f;
% y = gamryStructure_EIS_cell_Day01(1).Zmag;
% scatter( x, y)
% hold on
% % Transwell (commercial)
% x = gamryStructure_EIS_cell_Day01(4).f;
% y = gamryStructure_EIS_cell_Day01(4).Zmag;
% scatter( x, y)
% % Open lead
% x = gamryStructure_EIS_Open(7).f;
% y = gamryStructure_EIS_Open(7).Zmag;
% scatter( x, y)
% set(gca, 'YScale', 'log')
% set(gca, 'XScale', 'log')
% xlabel('Frequency (Hz)')
% ylabel('mag(Impedance) (Ohm)')
% xlim([9.9 1e6])
% legend( 'Print Wall', 'Transwell', 'Open Lead')
