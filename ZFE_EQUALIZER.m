clc;clear all;close all;
x=randi([0 1],1,10^6);
m=pskmod(x,2);
h=2+2i;
ber1=[];
ber2=[];
snr=0:1:30;
for i=1:length(snr)
    N=awgn(m.*h,snr(i),"measured");
    I=N/h;
    Without_eq=pskdemod(N,2);
    with_eq=pskdemod(I,2);
    ber1=[ber1 biterr(Without_eq,x)];
    ber2=[ber2 biterr(with_eq,x)]
end
BER1=ber1/length(x);
BER2=ber2/length(x);
semilogy(snr,BER1,'hexagram--c','Color','black');
hold on
semilogy(snr,BER2)
xlabel("SNR(in dB)");
ylabel("BER (in dB")
title('BER Vs SNR')
legend('BER without Equalizer','BER with Equalizer');