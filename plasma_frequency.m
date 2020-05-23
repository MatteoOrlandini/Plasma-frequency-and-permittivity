%The dispersion relation for a metal

clc;
clear all;
close all;

% universal costants
c = 3*10^8; %light velocity
q = 1.602176634*10^(-19); %electric charge
m_0 = 9.1093837015*10^(-31); %electron mass
epsilon_0 = 8.8541878128*10^(-12); % vacuum permittivity
%parameters
rho = 1.72*10^(-8); % copper resistivity
epsilon_r1 = 1; % permittivy material 1 (vacuum)
%m_e = 1.08; %effective mass (copper)
m_e = 1; %effective mass 
%n_e = 9.65*10^9; %silicon electron density
%n_e = 5.86*10^28; %conductor electron density (silver)
%n_e = 5.90*10^28; %conductor electron density (gold)
n_e = 8.47*10^28; %conductor electron density (copper)

omega_p = sqrt((n_e*q^2)/(epsilon_0*epsilon_r1*m_0*m_e)); %plasma frequency (ionosphere)

%calculation of dispersion relation 
omega_sp = omega_p/sqrt(epsilon_r1+1);
omega = linspace(0, omega_p, 50);
epsilon2 = 1 - omega_p^2./omega.^2; %permittivy material 2 (metal) this is a function of frequency
beta = omega/c.*sqrt((epsilon_r1*epsilon2)./(epsilon_r1+epsilon2));
index = find(omega > omega_sp, 1); %find index of omega > omega_sp
figure('Name', 'Plasma frequency', 'NumberTitle', 0);
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

%%%%%%  ?(?) %%%%%%%%%%%
%% electronic / ionic contibution to permittivity
figure('Name', 'Ionic and electronic contribution to ?(?)', 'NumberTitle', 0);
clear omega;
tau_plasma = 0; %  mean time between collision (in plasma)
omega_0_plasma = 0; % resonant frequency of the electron motion in plasma 
omega_0_conductor = 0; % resonant frequency of the electron motion in conductor
omega = linspace(0, omega_p); 
tau = m_0*m_e/(n_e*rho*(q^2)); % mean time between collision (in copper)
gamma = 1/tau; % damping coefficient
epsilon_r0 = 1; % relative dielectric constant normalized
omega_0 = omega_p/2; % resonant frequency of the electron motion (taken arbitrary)
epsilon_ie_real = epsilon_r0+((epsilon_r0*omega_p^2*(omega_0^2-omega.^2))./((omega_0^2-omega.^2).^2+omega.^2*gamma^2));
epsilon_ie_imag = epsilon_r0+((epsilon_r0*omega_p^2*omega*gamma)./((omega_0^2-omega.^2).^2+omega.^2*gamma^2));

subplot(2,1,1);
plot (omega, epsilon_ie_real);
xline(omega_0);
text (omega_0, min(epsilon_ie_real), '$\omega_0$','Interpreter', 'latex', 'VerticalAlignment', 'top', 'FontSize',14);
title ('$Re \{\epsilon(\omega)\}$', 'Interpreter', 'latex');
subplot(2,1,2);
plot (omega, epsilon_ie_imag);
xline(omega_0);
text (omega_0, min(epsilon_ie_imag), '$\omega_0$','Interpreter', 'latex', 'VerticalAlignment', 'top', 'FontSize', 14);
title ('$Im \{\epsilon(\omega)\}$', 'Interpreter', 'latex');

%% dipolar contibution to permittivity
clear omega;
omega = linspace(0, 10/tau);
sigma = n_e * q^2 /(m_e*m_0*gamma);
epsilon_dip_real = epsilon_r0+ sigma./(1+omega*tau);
epsilon_dip_imag = sigma*omega*tau./(1+(omega*tau).^2); 
figure('Name', 'Dipolar contribution to ?(?)', 'NumberTitle', 0);
subplot(2,1,1);
plot (omega, epsilon_dip_real);
xline(1/tau);
text (1/tau, 0, '$\omega\tau=1$','Interpreter', 'latex', 'HorizontalAlignment', 'center','VerticalAlignment', 'top', 'FontSize', 14);
title ('$Re \{\epsilon(\omega)\}$', 'Interpreter', 'latex');
subplot(2,1,2);
plot (omega, epsilon_dip_imag);
xline(1/tau);
text (1/tau, 0, '$\omega\tau=1$','Interpreter', 'latex', 'HorizontalAlignment', 'center','VerticalAlignment', 'top', 'FontSize', 14);
title ('$Im \{\epsilon(\omega)\}$', 'Interpreter', 'latex');

%% plot ?(?)
sigma_real = sigma./(1+(omega*tau).^2);
sigma_imag = sigma*omega*tau./(1+(omega*tau).^2);
figure('Name', "?(?)", 'NumberTitle', 0);
subplot(2,1,1);
plot (omega, sigma_real);
xline(1/tau);
text (1/tau, 0, '$\omega\tau=1$','Interpreter', 'latex', 'HorizontalAlignment', 'center','VerticalAlignment', 'top', 'FontSize', 14);
title ('$Re \{\sigma(\omega)\}$', 'Interpreter', 'latex');
subplot(2,1,2);
plot (omega, sigma_imag);
xline(1/tau);
text (1/tau, 0, '$\omega\tau=1$','Interpreter', 'latex', 'HorizontalAlignment', 'center','VerticalAlignment', 'top', 'FontSize', 14);
title ('$Im \{\sigma(\omega)\}$', 'Interpreter', 'latex');