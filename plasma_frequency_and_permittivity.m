%The dispersion relation for a metal

clc;
clear all;
close all;

% universal costants
c = 3*10^8; %light velocity
q = 1.602176634*10^(-19); % electric charge
m_0 = 9.1093837015*10^(-31); %electron mass
epsilon_0 = 8.8541878128*10^(-12); % vacuum permittivity
%parameters
rho = 1.72*10^(-8); % copper resistivity
epsilon_r1 = 1; % permittivy material 1 (vacuum)
%m_e = 1.08; % effective mass (copper)
m_e = 1; %effective mass 
%n_e = 9.65*10^9; % silicon electron density
%n_e = 5.86*10^28; % conductor electron density (silver)
%n_e = 5.90*10^28; % conductor electron density (gold)
n_e = 8.47*10^28; % conductor electron density (copper)

% plot parameters
number_of_points = 1000;
font_size = 14;
color_im = 'r';
color_real = 'b';

%calculation of dispersion relation 
omega_p = sqrt((n_e*q^2)/(epsilon_0*epsilon_r1*m_0*m_e)); % plasma frequency (ionosphere)
omega_sp = omega_p/sqrt(epsilon_r1+1); %surface plasmon frequency
omega = logspace(0, log10(omega_p), number_of_points); % set omega from 1 to omega_p
epsilon2 = 1 - omega_p^2./omega.^2; % permittivy material 2 (metal) this is a function of frequency
beta = omega/c.*sqrt((epsilon_r1*epsilon2)./(epsilon_r1+epsilon2));
index = find(omega > omega_sp, 1); % find index of omega > omega_sp
figure('Name', 'Dispersion relation', 'NumberTitle', 0);
% plot omega < omega_sp
plot (real(beta(1:index-1)), omega(1:index-1)); % plot omega < omega_sp
text (0, omega(index-1), "$\omega_{sp}$", 'Interpreter', 'latex', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right','FontSize', font_size);
% line at omega_sp
hold on
plot ([0 max(real(beta))],[omega_sp omega_sp]); % line at omega = omega_sp
% plot omega_sp < omega < omega_p
hold on
plot (real(beta(index:end)), omega(index:end)); % plot omega_sp < omega < omega_p
% plot omega > omega_p
hold on
beta = logspace (0, log10(max(real(beta))), number_of_points); % redefining beta for omega > omega_p
omega_plasma = sqrt(omega_p^2 + c^2*beta.^2); % compute omega > omega_p
plot (real(beta), omega_plasma); % plot omega > omega_p
text (0, omega_p, "$\omega_p$", 'Interpreter', 'latex', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right','FontSize', font_size);
% plot omega = c*beta asymptote 
hold on
plot (real(beta), c*real(beta)); % plot omega = c*beta 
%text (max(real(beta)), c*max(real(beta)), '$\leftarrow \omega = c \cdot \beta$', 'Interpreter', 'latex','FontSize', font_size);

xlim ([min(real(beta)) max(real(beta))]);
ylim ([min(omega) max(omega_plasma)]);
xlabel ("$\beta~\left[\frac{1}{m}\right]$", 'Interpreter', 'latex', 'FontSize', font_size);
ylabel ("$\omega~\left[\frac{rad}{s}\right]$", 'Interpreter', 'latex', 'FontSize', font_size);
title ("$\omega(\beta)$", 'Interpreter','latex', 'FontSize', font_size);
legend ("$\beta = \frac{\omega}{c} \sqrt{\frac{\epsilon_{r1} \epsilon_{r2}}{\epsilon_{r1}+\epsilon_{r2}}}$", "$\omega = \omega_{sp}$", "Prohibited region", "$\omega^2 = \omega_p^2 + c^2 \cdot \beta^2$", "$\omega = c \cdot \beta$",'Interpreter', 'latex', 'Location', 'eastoutside', 'FontSize', font_size);

%% electronic / ionic contibution to permittivity
figure('Name', 'Ionic and electronic contribution to permittivity', 'NumberTitle', 0);
clear omega;
%tau_plasma = 0; %  mean time between collision (in plasma)
%omega_0_plasma = 0; % resonant frequency of the electron motion in plasma 
%omega_0_conductor = 0; % resonant frequency of the electron motion in conductor
%omega = linspace(0, omega_p); 
omega = logspace(0, log10(10*omega_p), number_of_points);
tau = m_0*m_e/(n_e*rho*(q^2)); % mean time between collision (in copper)
gamma = 1/tau; % damping coefficient
omega_0 = omega_p/2; % resonant frequency of the electron motion (taken arbitrary)
epsilon_ie_real = epsilon_r1+((epsilon_r1*omega_p^2*(omega_0^2-omega.^2))./((omega_0^2-omega.^2).^2+omega.^2*gamma^2));
epsilon_ie_imag = epsilon_r1+((epsilon_r1*omega_p^2*omega*gamma)./((omega_0^2-omega.^2).^2+omega.^2*gamma^2));

subplot(2,1,1);
plot (omega, epsilon_ie_real, color_real);
set(gca, 'XScale', 'log');
xline(omega_0);
xlim ([10^(round(log10(omega_0/10))) 10^(round(log10(omega_0*10)))]);
xticks ([10^(round(log10(omega_0/10))) 10^(round(log10(omega_0*10)))]);
ylim ([min(epsilon_ie_real) max(epsilon_ie_real)]);
text (omega_0, min(epsilon_ie_real), '$\omega_0$','Interpreter', 'latex', 'VerticalAlignment', 'top', 'HorizontalAlignment', 'center', 'FontSize', font_size);
xlabel ('$\log(\omega)$', 'Interpreter', 'latex', 'FontSize', font_size);
ylabel ('Re $\{\epsilon(\omega)\}$', 'Interpreter', 'latex', 'FontSize', font_size);
title('Re $\{\epsilon(\omega)\}=\varepsilon_{r0}+\frac{\varepsilon_{r0} \omega_p^2 (\omega_0^2-\omega^2)}{(\omega_0^2-\omega^2)^2+ \omega^2 \Gamma^2}$', 'Interpreter', 'latex', 'FontSize', font_size);

subplot(2,1,2);
plot (omega, epsilon_ie_imag, color_im);
set(gca, 'XScale', 'log');
xline(omega_0);
xlim ([10^(round(log10(omega_0/10))) 10^(round(log10(omega_0*10)))]);
xticks ([10^(round(log10(omega_0/10))) 10^(round(log10(omega_0*10)))]);
ylim ([min(epsilon_ie_imag) max(epsilon_ie_imag)]);
text (omega_0, min(epsilon_ie_imag), '$\omega_0$','Interpreter', 'latex', 'VerticalAlignment', 'top', 'HorizontalAlignment', 'center', 'FontSize', font_size);
xlabel ('$\log(\omega)$', 'Interpreter', 'latex', 'FontSize', font_size);
ylabel ('Im $\{\epsilon(\omega)\}$', 'Interpreter', 'latex', 'FontSize', font_size);
title ('Im $\{\epsilon(\omega)\}=\frac{\varepsilon_{r0} \omega_p^2 \omega \Gamma}{(\omega_0^2 - \omega^2)^2+ \omega^2 \Gamma^2}$', 'Interpreter', 'latex', 'FontSize', font_size);

%% Dipolar contibution to permittivity
clear omega;
omega = logspace(0, log10(number_of_points/tau), number_of_points);
sigma = n_e * q^2 /(m_e*m_0*gamma);
epsilon_dip_real = epsilon_r1+ sigma./(1+omega*tau);
epsilon_dip_imag = sigma*omega*tau./(1+(omega*tau).^2); 
figure('Name', 'Dipolar contribution to permittivity', 'NumberTitle', 0);
subplot(2,1,1);
plot (omega, epsilon_dip_real, color_real);
set(gca, 'XScale', 'log');
xline(1/tau);
xlim ([1 10^(round(log10(1000/tau)))]);
text (1/tau, 0, '$\omega\tau = 1$','Interpreter', 'latex', 'HorizontalAlignment', 'center','VerticalAlignment', 'top', 'FontSize', font_size);
xlabel ('$\log(\omega)$', 'Interpreter', 'latex', 'FontSize', font_size);
ylabel ('Re $\{\epsilon(\omega)\}$', 'Interpreter', 'latex', 'FontSize', font_size);
title ('Re $\{\epsilon(\omega)\} = \varepsilon_{r0}+\frac{\sigma_0}{1+(\omega \tau)^2}$', 'Interpreter', 'latex', 'FontSize', font_size);

subplot(2,1,2);
plot (omega, epsilon_dip_imag, color_im);
set(gca, 'XScale', 'log');
xline(1/tau);
xlim ([1 10^(round(log10(1000/tau)))]);
text (1/tau, 0, '$\omega\tau = 1$','Interpreter', 'latex', 'HorizontalAlignment', 'center','VerticalAlignment', 'top', 'FontSize', font_size);
xlabel ('$\log(\omega)$', 'Interpreter', 'latex', 'FontSize', font_size);
ylabel ('Im $\{\epsilon(\omega)\}$', 'Interpreter', 'latex', 'FontSize', font_size);
title ('Im $\{\epsilon(\omega)\}=\frac{\sigma \omega \tau}{1+(\omega\tau)^2}$', 'Interpreter', 'latex', 'FontSize', font_size);