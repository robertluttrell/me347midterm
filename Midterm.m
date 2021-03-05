%% Midterm 1 Fluids II
% ME 347-03 Winter 2021 - Midterm Exam Problem
%
% Anil Singh, Robert Luttrell
%
% California Polytechnic State University, San Luis Obispo, CA
%
% 3/3/21
%% Housekeeping
clc; % Clears the command window
% clearvars; % Clears all variables
close all; % Closes all figures

%% Input Variables 
VFD_w = [10 20 30 40 50 60]; %[Hz]
Qcfm = [0:1:60000]; %[ft^3/m]
Q = Qcfm*(1/60); %[ft^3/s]

%% Fixed Parameters
% Motor Conversions
dsheave_motor = 8; %[in]
dsheave_fan = 10; %[in]
p = 4; %[#]

% Velocity Term
Aout_fan = 8.9; %[ft^2]
Ain_cont = 25; %[ft^2]
alpha1 = 1;
alpha2 = 1;
g = 32.174; %[ft/s^2]

% Test Section Major Loss
Lts = 4; %[ft]
Dts = 2; %[ft]
Ats = 4; %[ft^2]
fts = friction((Q./Ats), 0, Dts);

% Minor Loss Contraction
kcont = 0.2;
Aout_cont = 4; %[ft^2]

% Minor Loss 90deg Bend
k90 = 0.20;
A90 = 52.16/12; %[ft]

% Combined Diffuser Loss
beta = 7.01; %[deg]
D1 = 24/12; %[ft]
D2 = 52.16/12; %[ft]
D = 24/12; %[ft]
fd = friction((Q./(D^2)), 0, D);

% Honeycomb & High Porosity Mesh Losses
Ahp = 25; %[ft^2]
Ahc = 25; %[ft^2]
khp = 0.80;
khc = 0.20;

%% VFD input to Fan Speed
motor_w = 120*(VFD_w)/p; %[rpm]
gear_ratio = dsheave_motor/dsheave_fan;
fan_w = motor_w*gear_ratio; %[rpm]

%% System Curve Generation

velocity_term = (alpha2*((Q/Aout_fan).^2) - alpha1*((Q/Ain_cont).^2))/(2*g);
test_section_major = fts*(Lts/Dts)*(((Q/Ats).^2)/(2*g));
contraction_minor = kcont*(((Q/Aout_cont).^2)/(2*g));
ninety_deg_minor = k90*(((Q/A90).^2)/(2*g));
diffuser_combined = ((fd/(8*tan(beta/2)))+(0.6*tan(beta/2)))*(1-((D1^4)/(D2^4)))*((D^4)/(D1^4));
honeycomb_minor = khc*(((Q/Ahc).^2)/(2*g));
high_porosity_minor = khp*(((Q/Ahp).^2)/(2*g));



Hreq = velocity_term + test_section_major + contraction_minor + ninety_deg_minor + diffuser_combined + honeycomb_minor + high_porosity_minor;
H = Hreq*0.0155;
%% Plot System and Fan Curves

figure;
hold on;
% System curve
plot(Qcfm, H, "LineWidth", 2);

% Fan curves
omega_arr = [linspace(230, 1600, 10)];

for idx = 1:length(omega_arr)
   omega = omega_arr(idx);
   [h, q] = get_perf_curve_affinity(omega);
   plot(q, h, "LineWidth", 2);
end

hold off;
grid on;

xlabel('Flowrate (cfm)', "FontSize", 12);
ylabel('Head (in H2O)', "FontSize", 12);
title ('System and Fan Curves', "FontSize", 14);

saveas(gcf, "curves.png");

