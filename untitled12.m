clc; clear all; close all;
h = [0.9 0.3 0.5 -0.1]; SNRr = 30;runs = 100;
eta = 5e-3; order=12;
for run = 1 : runs
U = zeros(1,order); W = randn(1,order);N = 1000;
Bits = 2; data = randi([0 1],1,N);
d = real(pskmod(data,Bits)); r = filter(h,1,d);
x = awgn(r, SNRr);
for n = 1 : N
U(1,2:end) = U(1,1:end-1); U(1,1) = x(n); y = (W)*U';
e = d(n) - y; W = W + eta * e * U ; J(run,n) = e *e';
end
end
MJ = mean(J,1);
figure
plot((MJ))
trendMJ = polyval(polyfit((0:N),[0 (MJ)],7),(1:N));
hold on
plot(trendMJ)
grid minor
xlabel('Epochs iterations');
ylabel('Mean squared error (dB)');
title('Cost function');