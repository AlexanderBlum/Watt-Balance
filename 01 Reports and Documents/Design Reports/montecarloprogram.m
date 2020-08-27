%This program performs a Monte Carlo simulation to estimate the uncertainty
%in the measurement of mass. The measuring device is built based on Watt balance principle

clc;clear;close all;

%constants
v=0.024;    %maximum achievable velocity of the system
BL=13.2;    %Force sensitivity
V_cal=BL*v; %induced EMF

m=0.4;      %nominal test mass
g=9.80103;  %good 'ol gravity
I=m*g/BL;   %current required to zero the stage
R=2.2;      %sense resistance
V_m=I*R;    %voltage measured across sense resistor

m_est=V_cal*V_m/(v*R*g) %estimate of mass

%standard uncertainties
delV_cal=6e-3;
delV_m=6e-3;
delg=3e-5;
delR=1e-3;
delv=0.36e-5;
h=waitbar(0);

% MonteCarlo 1 million iteration
sd = 1;
for j=1:1000000
    waitbar(j/1000000,h,sprintf('processing: %0.2f%%',j/1000000*100))
m(j)=((V_cal+delV_cal*normrnd(0,sd))*(V_m+delV_m*normrnd(0,sd)))/...
      ((v+delv*normrnd(0,sd))*(R+delR*normrnd(0,sd))*(g+delg*normrnd(0,sd)));
end

figure()
histogram(m*1000)
xlabel('mass (g)');ylabel('number of observations');
