%% experiment_gelDiffusion_statistics
% Comparing diffusion between dextran sizes at 24 hours

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

%% Load Data
load('..\rawData\omega\diffusion_data_24hr');

%% Group Data
for ii = 1:length(diffusion_data)
    diff_data_matrix(:,ii) = diffusion_data(ii).p_permeability;
end
%% Statistics
% Coloums = groups; rows = measurements
[p,tbl,stats] = anova1(diff_data_matrix);

%% Calculate which groups are different from phase
multcompare(stats)

%%
% Percent permeability is significantly different between 10kDa dextrans
% and 40, 70, 250, and 500kDa dextrans. All except 20kDa!

%% Figure for EMBC
for ii = 1:6
    mean_array(ii) = mean(diff_data_matrix(:,ii));
    std_array(ii) = std(diff_data_matrix(:,ii));
end

figure
errorbar( [10 20 40 70 250 500], ...
        mean_array, ...
        std_array, 'LineWidth', 2.5, 'Color', 'k')
hold on
set(gca, 'XScale', 'log')
xlabel('Dextran Size (kDa)')
ylabel('% Permeability')
xlim([5 10^3])
ylim([0 110])
