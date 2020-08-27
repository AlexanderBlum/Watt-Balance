figure;histogram(m*1000,'Normalization','pdf')
hold on
y = 370:0.1:430;
mu = 0.00000000005;
sigma = 0.000000000000000002;
f = exp(-(y-mu).^2./(2*sigma^2))./(sigma*sqrt(2*pi));
plot(y,f,'LineWidth',1.5)