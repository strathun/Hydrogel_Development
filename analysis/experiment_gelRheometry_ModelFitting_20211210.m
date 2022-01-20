%% experiment_gelRheometry_ModelFitting_20211210
% Attempting to use methods from Coates et al 2006 to fit some of our
% rheometer data to estimate elastic modulus.

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
load('..\rawData\rheometer\matlab\20211210_8mm\gel4_relaxation.mat')

%% Plot
% Not really sure how to filter since the sampling frequency changes over
% time...
% Can probably digitally resample somehow. That or just boxcar.
% last cycle index
lastCycleStart = 483;
gel4_relaxT = gel4_relaxation.Times(lastCycleStart:end);
gel4_relaxStress = gel4_relaxation.ShearStressPa(lastCycleStart:end);
figure
scatter( gel4_relaxT, gel4_relaxStress, '.' )
set(gca, 'Xscale', 'log')
hold on

NN = 20;
B = 1/NN*ones(NN,1);
out = filter(B,1,gel4_relaxStress);
outT = filter(B,1,gel4_relaxT);
scatter(outT, out)
set(gca, 'Xscale', 'log')


% resample to 5ks/s
desiredFs = 50000;
[y, Ty] = resample(gel4_relaxStress, gel4_relaxT, desiredFs);
scatter( Ty, y)
set(gca, 'Xscale', 'log')

%% Model Fitting

% Know
gamma  = gel4_relaxation.Strain; % engineering shear strain. Equiv. to strain in our data.
% NOTE, may need divide above by gap distance
T12    = abs(gel4_relaxation.ShearStressPa)./(pi*(8e-3)^2); % Force divided by contact area. Strain/contact area. Leaving as mm for now

% Calculate
% alpha1 = []; % describes the nonlinear strain-magnitude sensity behavior. Calculated from Eqn. 4
% mu_t   = []; % viscoelastic shear modulus of the tissue. Calculated from Eqn 3, using alpha1 from Eqn. 4
lambda = []; % principal stretch ratio. See below

% Execution
% Step 1. Calculate lambda from Eqn. 2
lambda = (gamma./2) + (1 + ((gamma.^2)./4)).^(1/2);

% Step 2. "Normalize" Eqn. 3 to get Eqn. 4. This will allow us to calc
% alpha1. Assume lambda_0 = 0.5 for now. Need to have matlab fit this eqn
% and solve for alpha1
lambda_0 = 0.5;
isochrones = [101 125 140 164 240]; % indices for 100, 300, 600, 1800ms and 60s
% eqn4 = (((lambda(isochrones)^(alpha1))-(lambda(isochrones)^(-1*alpha1)))*((lambda_0)+(lambda_0^(-1))))/...
%        (((lambda_0^(alpha1))-(lambda_0^(-1*alpha1)))*((lambda(isochrones))+(lambda(isochrones)^(-1))));
x = lambda(isochrones);
y = T12(isochrones);
% eqn4 = (((x^(alpha1))-(x^(-1*alpha1)))*((lambda_0)+(lambda_0^(-1))))/...
%        (((lambda_0^(alpha1))-(lambda_0^(-1*alpha1)))*((x)+(x^(-1))));
strt_point = 0.01; % starting estimate for alpha1
% fitfun = fittype( @(alpha1, x) (((x.^(alpha1))-(x.^(-1*alpha1)))*((lambda_0)+(lambda_0^(-1))))/(((lambda_0^(alpha1))-(lambda_0^(-1*alpha1)))*((x)+(x.^(-1)))));
fitfun = fittype('(((x.^(alpha1))-(x.^(-1*alpha1)))*((0.5)+(0.5^(-1))))./(((0.5^(alpha1))-(0.5^(-1*alpha1)))*((x)+(x.^(-1))))', ...
                 'dependent', {'y'}, 'independent', {'x'}, 'coefficients', {'alpha1'});
[fitted_curve, gof] = fit(x, y, fitfun, 'StartPoint', strt_point);

coeffvals = coeffvalues(fitted_curve);


% I think the problem is that the data (y) needs to be normalized first. Or
% possibly that the above equation is not correct. Try plotting something
% with an estimated alpha1 from the paper and see what happens. 
% Poke around with the x values. I htink the range is too small, which
% means these numbers might be too small. 

% plot results to check
figure
scatter(x, y)
hold on
plot(x, fitted_curve(x))
hold off
%%
% Not sure why the above is - version of the values...

%% Step 3. Calculate mu_t using alph1 and eqn. 3
alpha1 = coeffvals;
for ii = 1:length(isochrones)
    mu_t(ii) = (y(ii)*(x(ii) + x(ii)^(-1))*alpha1)/(2*((x(ii)^alpha1) - (x(ii)^(-1*alpha1)) ));
end