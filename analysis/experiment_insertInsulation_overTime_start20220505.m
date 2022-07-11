%% experiment_insertInsulation_overTime_start20220505
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

%% Individual Measurement Plots
% Impedance
figure
[~, numRuns] = size(gamryStructure_EIS_cell_Day01);
colorArray = lines(numRuns);
for ii = 1:numRuns
    x = gamryStructure_EIS_cell_Day01(ii).f;
    y = gamryStructure_EIS_cell_Day01(ii).Zmag;
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
for ii = 1:numRuns
    x = gamryStructure_EIS_cell_Day01(ii).f;
    y = gamryStructure_EIS_cell_Day01(ii).Phase;
    scatter( x, y, [], colorArray( ii, : ))
    hold on
%     
%     fit_vals = polyfit(log(x(1:end-20)), log(y(1:end-20)), 1);
%     fit_line = polyval(fit_vals, log(x(1:end-20)));
%     plot( x(1:end-20), exp(fit_line) , 'LineWidth', 1.5,...
%           'Color', colorArray( ii, : ))
end
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')
xlim([9.9 1e6])
title('Phase')
legend( 'Print01', 'Print02', 'Print03', 'Twell01', 'Twell02', 'Twell03')
title('Day 00 - Individual Measurements - Phase')

figure
[~, numRuns] = size(gamryStructure_EIS_cell_Day02);
colorArray = lines(numRuns);
for ii = 1:numRuns
    x = gamryStructure_EIS_cell_Day02(ii).f;
    y = gamryStructure_EIS_cell_Day02(ii).Zmag;
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
        'Twell01', '', 'Twell02', '', 'Twell03', '' )
title('Day 05 - Individual Measurements - Impedance')

% Phase
figure
for ii = 1:numRuns
    x = gamryStructure_EIS_cell_Day02(ii).f;
    y = gamryStructure_EIS_cell_Day02(ii).Phase;
    scatter( x, y, [], colorArray( ii, : ))
    hold on
%     
%     fit_vals = polyfit(log(x(1:end-20)), log(y(1:end-20)), 1);
%     fit_line = polyval(fit_vals, log(x(1:end-20)));
%     plot( x(1:end-20), exp(fit_line) , 'LineWidth', 1.5,...
%           'Color', colorArray( ii, : ))
end
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')
xlim([9.9 1e6])
title('Phase')
legend( 'Print01', 'Print02', 'Print03', 'Twell01', 'Twell02', 'Twell03')
title('Day 05 - Individual Measurements - Phase')

figure
[~, numRuns] = size(gamryStructure_EIS_cell_Day03);
colorArray = lines(numRuns);
for ii = 1:numRuns
    x = gamryStructure_EIS_cell_Day03(ii).f;
    y = gamryStructure_EIS_cell_Day03(ii).Zmag;
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
        'Twell01', '', 'Twell02', '', 'Twell03', '' )
title('Day 07 - Individual Measurements - Impedance')

% Phase
figure
for ii = 1:numRuns
    x = gamryStructure_EIS_cell_Day03(ii).f;
    y = gamryStructure_EIS_cell_Day03(ii).Phase;
    scatter( x, y, [], colorArray( ii, : ))
    hold on
%     
%     fit_vals = polyfit(log(x(1:end-20)), log(y(1:end-20)), 1);
%     fit_line = polyval(fit_vals, log(x(1:end-20)));
%     plot( x(1:end-20), exp(fit_line) , 'LineWidth', 1.5,...
%           'Color', colorArray( ii, : ))
end
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')
xlim([9.9 1e6])
title('Phase')
legend( 'Print01', 'Print02', 'Print03', 'Twell01', 'Twell02', 'Twell03')
title('Day 12 - Individual Measurements - Phase')

figure
[~, numRuns] = size(gamryStructure_EIS_cell_Day04);
colorArray = lines(numRuns);
for ii = 1:numRuns
    x = gamryStructure_EIS_cell_Day04(ii).f;
    y = gamryStructure_EIS_cell_Day04(ii).Zmag;
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
legend( 'Print01', '', 'Print02', '', 'Print03 - r1', '', 'Print03 - r2', '', ...
        'Twell01', '', 'Twell02', '', 'Twell03', '' )
title('Day 12 - Individual Measurements - Impedance')

% Phase
figure
for ii = 1:numRuns
    x = gamryStructure_EIS_cell_Day04(ii).f;
    y = gamryStructure_EIS_cell_Day04(ii).Phase;
    scatter( x, y, [], colorArray( ii, : ))
    hold on
%     
%     fit_vals = polyfit(log(x(1:end-20)), log(y(1:end-20)), 1);
%     fit_line = polyval(fit_vals, log(x(1:end-20)));
%     plot( x(1:end-20), exp(fit_line) , 'LineWidth', 1.5,...
%           'Color', colorArray( ii, : ))
end
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')
xlim([9.9 1e6])
title('Phase')
legend( 'Print01', 'Print02', 'Print03', 'Print03 - r2', 'Twell01', 'Twell02', 'Twell03')
title('Day 12 - Individual Measurements - Phase')

figure
[~, numRuns] = size(gamryStructure_EIS_cell_Day05);
colorArray = lines(numRuns);
for ii = 1:numRuns
    x = gamryStructure_EIS_cell_Day05(ii).f;
    y = gamryStructure_EIS_cell_Day05(ii).Zmag;
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
legend( 'Print01', '', 'Print02', '', 'Print03 - r1', '', 'Print03 - r2', '', ...
        'Twell01', '', 'Twell02', '', 'Twell03', '' )
title('Day 14 - Individual Measurements - Impedance')

% Phase
figure
for ii = 1:numRuns
    x = gamryStructure_EIS_cell_Day05(ii).f;
    y = gamryStructure_EIS_cell_Day05(ii).Phase;
    scatter( x, y, [], colorArray( ii, : ))
    hold on
%     
%     fit_vals = polyfit(log(x(1:end-20)), log(y(1:end-20)), 1);
%     fit_line = polyval(fit_vals, log(x(1:end-20)));
%     plot( x(1:end-20), exp(fit_line) , 'LineWidth', 1.5,...
%           'Color', colorArray( ii, : ))
end
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase')
xlim([9.9 1e6])
title('Phase')
legend( 'Print01', 'Print02', 'Print03', 'Print03 - r2', 'Twell01', 'Twell02', 'Twell03')
title('Day 14 - Individual Measurements - Phase')
%% Individual Plots Over time
[~, numRuns] = size(gamryStructure_EIS_cell_Day01);
colorArray = lines(5);

% Day 0
for ii = 1:numRuns
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

%%
% With the exception of one hiccup (Day 07 of print02), it does seem that
% there is a pretty consistent trend that occurs with the printed wells
% over time. There is an initital drop in impedance and then likely some
% continued reduction with time. However, the initial time point at which
% this drop occurs is highly variable occuring between Day 00 and 05 
% in solution in the worst case and between day 12 and 14 in the "best" 
% case. While the mechanism is unknown, and the change is fairly
% substantial, I don't believe it will be significant enough to influence
% our results. AND it is worth noting in the paper that if we do see a
% change in impedance with the monolayer development, then we can be even
% more convinced of its legitimacey since the effect observed above would
% only result in reduced impedances for the membrane since the two would be
% in parallel. 

%% Looking at saturation as potential cause of changing impedance
[~, numRuns] = size(gamryStructure_EIS_cell_Day06);
colorArray = lines(6);

% Day 0
for ii = 1:1
    figure(ii+200)
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
    
    % After drying out over the weekend
    plot_array = 1;
    kk = plot_array(ii);
    x = gamryStructure_EIS_cell_Day06(kk).f;
    y = gamryStructure_EIS_cell_Day06(kk).Zmag;
    scatter( x, y, [], colorArray( 6, : ))
    hold on
    fit_vals = polyfit(log(x(1:end-20)), log(y(1:end-20)), 1);
    fit_line = polyval(fit_vals, log(x(1:end-20)));
    plot( x(1:end-20), exp(fit_line) , 'LineWidth', 1.5,...
          'Color', colorArray( 6, : ))
    
    set(gca, 'YScale', 'log')
    set(gca, 'XScale', 'log')
    xlabel('Frequency (Hz)')
    ylabel('mag(Impedance) (Ohm)')
    xlim([9.9 1e6])
    legend( 'Day 00', '', 'Day 05', '', 'Day 07', '', 'Day 12', '', 'Day 14', '', 'Post-Drying', '')
end

%%
% Looks like rinsing with diH20 and drying out for 72 hours is sufficient
% to restore the impedance of the insert back to its initial impedance
% values. This suggests that if there is any degredation of the plastic, it
% is not sufficient to cause substantial change to its impedance. Instead,
% what appears to be happening is the plastic is becoming saturated with
% solution that provides additional parallel current pathways. It is
% important to note that the impedance values are still quite high and
% should not cause substantial error when measuring the membranes, at least
% across a 2 week period (see manuscript draft for more discussion). In
% addition, methods that reduce hte permeability (modified printing
% settings, application of coatings, etc.) are expected to mitigate, if not
% completely abolish this issue. 

%% Worst case error
% quick calculation for a sort of worst case error situation, where we look
% at the lowest recorded impedance here and compare that to a previously
% measured in vivo impedance. 

% Looking for a good candidate electrode to use.
figure
for ii = 1:16
    x = gamryStructure_EIS_TDT_InVivo(ii).f;
    y = gamryStructure_EIS_TDT_InVivo(ii).Zmag;
    scatter( x, y)
    hold on  
end
legend('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12','13', '14', '15', '16') 

% Comparing to print 02, Day 14
figure
x = gamryStructure_EIS_cell_Day05(2).f;
y = gamryStructure_EIS_cell_Day05(2).Zmag;
scatter( x, y, [], colorArray( 5, : ))
hold on
% Use E05 if using the 07-30 dataset; 10 for 0320
x = gamryStructure_EIS_TDT_InVivo(10).f;
y = gamryStructure_EIS_TDT_InVivo(10).Zmag;
scatter( x, y)
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
xlim([9.9 1e6])
legend( 'Print Wall', 'In vivo imp - Day ')

%% Calculate errors
imp_diff = abs(gamryStructure_EIS_cell_Day05(2).Zmag - ...
               gamryStructure_EIS_TDT_InVivo(10).Zmag);

% Calculate what the estimated impedances would be given the two parallel
% impedances
inv_wall = 1./gamryStructure_EIS_cell_Day05(2).Zmag;
inv_vivo = 1./gamryStructure_EIS_TDT_InVivo(10).Zmag;
imp_calc = 1./(inv_wall + inv_vivo);

imp_error = (abs(gamryStructure_EIS_TDT_InVivo(10).Zmag - imp_calc))./...
             gamryStructure_EIS_TDT_InVivo(10).Zmag;
imp_error = imp_error * 100;

x = gamryStructure_EIS_TDT_InVivo(ii).f;
y = imp_error;
yyaxis right
ylabel('Error %')
scatter( x, y)
title('Day 14 soak')

%% 
% Error is pretty damn big. Let's look at it if we use a fresh insert
% whenever measuring impedance
% Comparing to print 02, Day 14
figure
x = gamryStructure_EIS_cell_Day01(2).f;
y = gamryStructure_EIS_cell_Day01(2).Zmag;
scatter( x, y, [], colorArray( 5, : ))
hold on
% Use E05 if using the 07-30 dataset; 10 for 0320
x = gamryStructure_EIS_TDT_InVivo(10).f;
y = gamryStructure_EIS_TDT_InVivo(10).Zmag;
scatter( x, y)
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
xlim([9.9 1e6])
legend( 'Print Wall', 'In vivo imp - Day ')

imp_diff = abs(gamryStructure_EIS_cell_Day01(2).Zmag - ...
               gamryStructure_EIS_TDT_InVivo(10).Zmag);

% Calculate what the estimated impedances would be given the two parallel
% impedances
inv_wall = 1./gamryStructure_EIS_cell_Day01(2).Zmag;
inv_vivo = 1./gamryStructure_EIS_TDT_InVivo(10).Zmag;
imp_calc = 1./(inv_wall + inv_vivo);

imp_error = (abs(gamryStructure_EIS_TDT_InVivo(10).Zmag - imp_calc))./...
             gamryStructure_EIS_TDT_InVivo(10).Zmag;
imp_error = imp_error * 100;

x = gamryStructure_EIS_TDT_InVivo(ii).f;
y = imp_error;
yyaxis right
ylabel('Error %')
scatter( x, y)
title('Day 00 soak')

%% 
% Alright, so if we use fresh inserts, then the impedance error drops down
% to 10% for impedances below 100kHz and below 5% below 10kHz. This will
% have to be the protocol until we figure something else out. 

%% Comparison of print, transwell, and open lead
figure
% Print wall
x = gamryStructure_EIS_cell_Day01(1).f;
y = gamryStructure_EIS_cell_Day01(1).Zmag;
scatter( x, y)
hold on
% Transwell (commercial)
x = gamryStructure_EIS_cell_Day01(4).f;
y = gamryStructure_EIS_cell_Day01(4).Zmag;
scatter( x, y)
% Open lead
x = gamryStructure_EIS_Open(7).f;
y = gamryStructure_EIS_Open(7).Zmag;
scatter( x, y)
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
xlim([9.9 1e6])
legend( 'Print Wall', 'Transwell', 'Open Lead')
