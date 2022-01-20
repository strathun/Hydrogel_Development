%% experiment_gelRheometry_20211124
% Generating figures from this experiment

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
load('20211124_alginate_testRun.mat')

%% Elastic and Viscous Modulus

figure
yyaxis left
semilogx(strain, elastic_mod, '-o', 'LineWidth', 1.5)
ylabel('Elastic Modulus (Pa)')
hold on
yyaxis right
semilogx(strain, viscous_mod, '-o', 'LineWidth', 1.5)
ylabel('Viscous Modulus (Pa)')
xlabel('Strain (%)')

figure
semilogx(strain, elastic_mod, '-o', 'LineWidth', 1.5)
ylabel('Elastic Modulus (Pa)')
hold on
xlabel('Strain (%)')

%% Make average elastic mod plot
% Calculate modulus
% Cutting off at around 7% = index 27
avg_elastic_mod = mean(elastic_mod(1:27));
avg_elastic_mod_array = ones(length(elastic_mod),1);
avg_elastic_mod_array = avg_elastic_mod_array * avg_elastic_mod;

% Plot
figure
semilogx(strain, elastic_mod, '-o', 'LineWidth', 1.5)
hold on
semilogx(strain, avg_elastic_mod_array, '-.', 'LineWidth', 1.5, 'Color', 'k')
ylabel('Elastic Modulus (Pa)')
xlabel('Strain (%)')