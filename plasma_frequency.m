%The dispersion relation for a metal

clc;
clear all;
close all;

% costants
c = 3*10^8; %light velocity
%n_e = 9.65*10^9; %silicon electron density
n_e = 10^23; %conductor electron density
q = 1.602176634*10^(-19); %electric charge
epsilon1 = 1; %%permittivy material 1 (dielectric), vacuum permittivy
m_e = 9.1093837015*10^(-31); %electron mass
omega_p = sqrt((n_e*q^2)/(epsilon1*m_e)); %plasma frequency (ionosphere)

%calculation of dispersion relation 
omega_sp = omega_p/sqrt(epsilon1+1);
omega = linspace(0, omega_p, 50);
epsilon2 = 1 - omega_p^2./omega.^2; %permittivy material 2 (metal) this is a function of frequency
beta = omega/c.*sqrt((epsilon1*epsilon2)./(epsilon1+epsilon2));
index = find(omega > omega_sp, 1); %find index of omega > omega_sp
figure;
plot (real(beta(1:index-1)), omega(1:index-1)); %plot omega < omega_sp
text (0, omega(index-1), "$\omega_{sp}$", 'Interpreter', 'latex', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right','FontSize',14);
hold on
plot ([0 max(real(beta))],[omega_sp omega_sp]); %line at omega_sp
hold on
plot (real(beta(index:end)), omega(index:end)); %plot omega_sp < omega < omega_p
hold on
beta = linspace (0, max(real(beta))); %redefining beta for omega > omega_p
omega_plasma = sqrt(omega_p^2 + c^2*beta.^2); % plot omega > omega_p
plot (real(beta), omega_plasma); % plot omega > omega_p
text (0, omega_p, "$\omega_p$", 'Interpreter', 'latex', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right','FontSize',14);
hold on
plot (real(beta), c*real(beta));
text (max(real(beta)), c*max(real(beta)), '$\leftarrow \omega = c \cdot \beta$', 'Interpreter', 'latex','FontSize',14);

xlabel ("$\beta~\left[\frac{1}{m}\right]$", 'Interpreter', 'latex', 'FontSize', 14);
ylabel ("$\omega~\left[\frac{rad}{s}\right]$", 'Interpreter', 'latex', 'FontSize', 14);
title ("$\omega(\beta)$", 'Interpreter','latex');
legend ("$\beta = \frac{\omega}{c} \sqrt{\frac{\epsilon_{r1} \epsilon_{r2}}{\epsilon_{r1}+\epsilon_{r2}}}$", "$\omega = \omega_{sp}$", "Prohibited region", "$\omega^2 = \omega_p^2 + c^2 \cdot \beta^2$", "$\omega = c \cdot \beta$",'Interpreter', 'latex', 'Location', 'eastoutside', 'FontSize', 14);