clc; clear; close all;
N=1000;u=0.02;f=2;
x=randi([0 1],1,N);
dn=pskmod(x,2);
%[b,a]=butter(f,0.5);
a=[1.56 -0.81];
b=1;
xn=filter(b,a,dn);
w=zeros(f,1);
xb=zeros(f,1);
ens=[];
for n=1:N
    xb(2:end)=xb(1:end-1);
    xb(1)=xn(n);
    y(n)=w(:,n)'*xb;
    e(n)=dn(n)-y(n);
    ens=[ens e(n)];
    w=[w w(:,n)+(u.*e(n).*xb)];
end
subplot(2,1,1)
plot(0:N,w)
xlabel('Number of iterations')
ylabel('Filter coefficients')
title('filter coefficients Vs Number of iterations')
subplot(2,1,2)
plot(0:N-1,(ens.^2))
xlabel('Number of iterations')
ylabel('Mean square error')
title('mean square error Vs Number of iterations')