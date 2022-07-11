%% experiment_insertInsulation_overTime_start20220707
% Testing to see if the new double chamber inserts remain electrochemically
% insulated across 2 weeks. All are superglued to the bottom of a 12 well 
% plate. 
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
    extractImpedanceDataGlobal('..\rawData\Gamry\20220707_WPI03_Insert_insulation_Day00');
% [gamryStructure_EIS_cell_Day02] = ...
%     extractImpedanceDataGlobal('..\rawData\Gamry\20220510_WPI03_Insert_insulation_Day05');
% [gamryStructure_EIS_cell_Day03] = ...
%     extractImpedanceDataGlobal('..\rawData\Gamry\20220512_WPI03_Insert_insulation_Day07');

%% Individual Measurement Plots
%%% Day 00 %%%
% % Impedance 
figure
[~, numRuns] = size(gamryStructure_EIS_cell_Day01);
colorArray = lines(numRuns/2);
for ii = 1:6
    % wall only
    x = gamryStructure_EIS_cell_Day01((ii*2)-1).f;
    y = gamryStructure_EIS_cell_Day01((ii*2)-1).Zmag;
    scatter( x, y, [], colorArray( ii, : ))
    hold on
    % wall + de-embedded cap
    x = gamryStructure_EIS_cell_Day01(ii*2).f;
    y = gamryStructure_EIS_cell_Day01(ii*2).Zmag;
    C = 33.71e-12; % Calculated using fit in EChem Analyst (Gamry)
    yZ = (y)./(1-(2*pi.*x.*y.*C));
    plot( x, yZ, '-o', 'Color', colorArray( ii, : ))
end
set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('mag(Impedance) (Ohm)')
xlim([9.9 1e6])
legend( 'Print01-Wall', 'Print01-De-Embed', 'Print02-Wall', 'Print02-De-Embed',...
        'Print03-Wall', 'Print03-De-Embed', 'Print04-Wall', 'Print04-De-Embed',...
        'Print05-Wall', 'Print05-De-Embed', 'Print06-Wall', 'Print06-De-Embed')
title('Day 00 - Individual Measurements - Impedance')

% % Phase
figure
for ii = 1:6
    % wall only
    x = gamryStructure_EIS_cell_Day01((ii*2)-1).f;
    y = gamryStructure_EIS_cell_Day01((ii*2)-1).Phase;
    scatter( x, y, [], colorArray( ii, : ))
    hold on
    % wall + de-embedded cap
    x = gamryStructure_EIS_cell_Day01(ii*2).f;
    y = gamryStructure_EIS_cell_Day01(ii*2).Phase;
    plot( x, y, '-o', 'Color', colorArray( ii, : ))
end
set(gca, 'XScale', 'log')
xlabel('Frequency (Hz)')
ylabel('Phase (Degrees)')
legend( 'Print01-Wall', 'Print01-De-Embed', 'Print02-Wall', 'Print02-De-Embed',...
        'Print03-Wall', 'Print03-De-Embed', 'Print04-Wall', 'Print04-De-Embed',...
        'Print05-Wall', 'Print05-De-Embed', 'Print06-Wall', 'Print06-De-Embed')
title('Day 00 - Individual Measurements - Phase')

%% Individual Plots Over time Prints_r3
colorArray = lines(3);

for ii = 1:6
    figure(ii+100)
    % Day 00
    plot_order = [2 4 6 8 10 12];
    jj = plot_order(ii);
    x = gamryStructure_EIS_cell_Day01(jj).f;
    y = gamryStructure_EIS_cell_Day01(jj).Zmag;
    C = 33.71e-12; % Calculated using fit in EChem Analyst (Gamry)
    yZ = (y)./(1-(2*pi.*x.*y.*C));
    scatter( x, yZ, [], colorArray( 1, : ))
    hold on
    fit_vals = polyfit(log(x(1:end-20)), log(yZ(1:end-20)), 1);
    fit_line = polyval(fit_vals, log(x(1:end-20)));
    plot( x(1:end-20), exp(fit_line) , 'LineWidth', 1.5,...
          'Color', colorArray( 1, : ))
    
    set(gca, 'YScale', 'log')
    set(gca, 'XScale', 'log')
    xlabel('Frequency (Hz)')
    ylabel('mag(Impedance) (Ohm)')
    xlim([9.9 1e6])
    legend( 'Day 00', '')
end

%% Liquid permeability % Parallel Plate
% Leaving this in for now as a comparison to the cylinder calculation
% need to update this one! need to use cylindrical capacitor equation, not
% parallel plate. 
% C = (2*pi*Eo*l)/(ln(R2/R1))
permitivitty_constant_vaccuum = 8.85e-12;
shell_height = 7.6e-3; % 9.6 (real - 2mm offset of liquid)
shell_thickness = 1.4e-3;
shell_diameter = 17e-3;
shell_area = (shell_height)*(pi*shell_diameter);

% Calc perm constants
cap_day00 = [ 11.78e-12; 10.13e-12; 10.66e-12; 10.65e-12; 10.41e-12; 9.935e-12 ];
for ii = 1:6
    perm_constant(ii) = cap_day00(ii)*((shell_thickness)/ ...
                    (shell_area));
    rel_perm_constant(ii) = perm_constant(ii)/permitivitty_constant_vaccuum;
end

% Liquid penetration estimate
for ii = 1:6
    calc_shell_thickness_day00(ii) = perm_constant(ii)*shell_area/cap_day00(ii);
end

%% Liquid permeability % Cylindrical Capacitor
% C = (2*pi*Eo*l)/(ln(R2/R1))
permitivitty_constant_vaccuum = 8.85e-12;
shell_height = 7.6e-3; % 9.6 (real - 2mm offset of liquid) ('l' in equation above)
shell_thickness = 1.4e-3;
R1 = (17e-3)/2; % radius of the inner chamber
R2 = R1 + shell_thickness; % inner radius of the outer cylinder: distance from center to outer chamber surface


% Calc perm constants
cap_day00 = [ 11.78e-12; 10.13e-12; 10.66e-12; 10.65e-12; 10.41e-12; 9.935e-12 ];
for ii = 1:6
    perm_constant_cyl(ii) = ( cap_day00(ii)*( log( R2/R1 ) ) )/ ...
                    ( 2*pi*shell_height );
    rel_perm_constant_cyl(ii) = perm_constant_cyl(ii)/permitivitty_constant_vaccuum;
end

% Liquid penetration estimate
% Solve for R2/R1 ratio, then just assume that R1 is constant and calculate
% R2 from that to approximate the total change in R2-R1 (shell thickness)
for ii = 1:6
    radii_ratio = exp( (2*pi*perm_constant_cyl(ii)*shell_height)/cap_day00(ii) );
    R2_new = radii_ratio*R1;
    calc_shell_thickness_day00_cyl(ii) = R2_new - R1;
end
