%% Angabe
clear all

s = tf('s');

u_e = 5;   % Überschwingen in Prozent
t_r = 0.7;  % Anstiegszeit in Sekunden

G = (9*(1+5/3*s)^2)/(s*(1+1/50*s+s^2));  % Übertragungsfunktion der Strecke
%% Rechnen imperische Werte
w_C = 1.5/t_r;
phi_r = 70-u_e;
%Der offene Kreis muss mindestens eine einfache Polstelle bei s = 0 haben.
%Wenn bleibende Regelabweichung einer Sprungfunktion = 0, dann 1/s
%Wenn bleibende Regelabweichung einer Rampenfunktion = 0, dann 1/s^2
%% Versuchen KOMPENSATIONS-REGLERENTWURF
R1 = (1+1/50*s+s^2)/s;
L1 = R1 * G;
[mag, phi, ~] = bode(L1, w_C);

phi_soll = -180 + phi_r;
delta_phi = phi - phi_soll;

TR = tan(delta_phi/2 *pi/180)/ w_C;
%%
R2 = R1 * 1/(1+s*TR)^2;

L2 = G * R2;
[mag, phi, ~] = bode(L2, w_C);

VR = 1/mag;

R = R2 * VR

F = R*G/(1+R*G);

figure(1);
step(F);

figure(2);
margin(R*G);

figure(3);
pzmap(G);