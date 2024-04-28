clc; clear all; close all;
 message = randi([0,1],1,10000);
 snr = 0:2:40; mod = 2;
 L = 2; r = 3; % 3 TAP EQUALISER
 modulated_bpsk_msg = pskmod(message,mod);
 h0 = 1; h1 = 0.7;
 H = zeros(r,r+L-1); % ORDER OF H MATRIX
 % FORMING H MATRIX FOR 3 TAP EQUALISER
 for p = 1:r
 H(p,p:p+L-1) = [h0 h1];
 end
 x = []; % FORMING INPUT MATRIX X
 X = modulated_bpsk_msg; X_1 = circshift(X,1);
 X_1(1) = 0; X1 = circshift(X,-1);
 X1(end) = 0; X2 = circshift(X,-2);
 X2(end-1:end)= 0; x = [X2;X1;X;X_1];
 C = ((H*H')\H)*[0;0;1;0];
 ber_without_ZFE = []; ber_with_ZFE = [];
 for p = 1:length(snr)
 y = awgn([h0 h1]*[X;X_1],snr(p),'measured');
 Noise = y- ([h0 h1]*[X;X_1]);
 Noise_1 = circshift(Noise,-1);
 Noise_1(end) = 0; Noise_2 = circshift(Noise,-2);
 Noise_1(end-1:end) = 0;
 Y = (H*x)+ [Noise_2;Noise_1;Noise]; X_PRIME = C.'*Y;
 Demodulated_BPSK_msg_with_ZFE =pskdemod(X_PRIME',mod);
 Demodulated_BPSK_msg_without_ZFE = pskdemod(y',mod);
 [number1,ratio1] = biterr(message,Demodulated_BPSK_msg_with_ZFE');
 [number2,ratio2] = biterr(message,Demodulated_BPSK_msg_without_ZFE');
 ber_with_ZFE = [ber_with_ZFE,ratio1];
 ber_without_ZFE = [ber_without_ZFE,ratio2];
 end
 semilogy(snr,ber_with_ZFE,'-k','LineWidth',1.6)
 hold on
 semilogy(snr,ber_without_ZFE,'--k','LineWidth',1.8)
 hold on
 n = length(message); M = 25; w = zeros(1,M);
 wi = zeros(1,M); E = []; mu = 0.0005;
 msg_bpsk = pskmod(message,mod);
 ber_without_LMS = []; ber_with_LMS = [];
 for k = 1:length(snr)
 msg_rx = awgn(msg_bpsk, snr(k), 'measured');
 for i = M:n
 E(i) = msg_bpsk(i)- wi*msg_rx(i:-1:i-M+1)';
 wi = wi + 2*mu*E(i)*msg_rx(i:-1:i-M+1);
 end
 msg_eq = zeros(n,1);
 for i = M:n
 j = msg_rx(i:-1:i-M+1);
 msg_eq(i) = ((wi)*(j)');
 end
 Demod_with_LMS = pskdemod(msg_eq,mod)';
 Demod_without_LMS = pskdemod(msg_rx,mod);
 [n1,r1] = biterr(message,Demod_with_LMS);
 [n2,r2] = biterr(message,Demod_without_LMS);
 ber_without_LMS = [ber_without_LMS,r1];
 ber_with_LMS = [ber_with_LMS,r2];
 end
 grid on; semilogy(snr,ber_with_LMS,'-*k','LineWidth',1.2)
 title('SNR VS BER'); xlabel('SNR(dB)');ylabel('BER');
 legend('BER WITHOUT EQUALIZATION','BER WITH ZFE','BER WITH LMS')