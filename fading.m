clc;
clear;
close all;
fs=1000; %Sampling frequency
f1=100;
f2=400;
t= 0:1/fs:1-1/fs; %Defining time interval using fs
x1=cos(2*pi*f1*t)+cos(2*pi*f2*t);
figure()
subplot(2,1,1)
plot(t,x1);
xlabel("Time --->");
ylabel("Amplitude --->");
title("Generation of dual tone signal");
x1_f=fft(x1);
f = fs/2*linspace(-1,1,fs); %calculate the frequency axis, which is defined by the sampling rate
subplot(2,1,2)
plot(f,abs(x1_f));
xlabel("Frequency --->");
ylabel("Amplitude --->");
title("Spectrum of the dual tone signal");
%generation of delayed signal 
n=77;
for i=1:length(x1)
if i<=n
x2(i)=0;
end
if (i>n)
x2(i)=x1(i-n);
end
end
figure()
subplot(2,1,1)
plot(t,x2);
xlabel("Time --->");
ylabel("Amplitude --- >");
title("Generation of dual tone delayed signal");
x2_f=fft(x2);
f = fs/2*linspace(-1,1,fs);
%calculate the frequency axis, which is defined by the sampling rate
subplot(2,1,2)
plot(f,abs(x2_f));
xlabel("Frequency --->");
ylabel("Amplitude --- >");
title("Spectrum of the dual tone delayed signal");
%%slow flat fading
h1=randn+1i*(randn);
sff=h1.*x1;
sff_f=fft(sff);
figure()
subplot(2,1,1)
plot(f,abs(x1_f));
xlabel("Frequency --->");
ylabel("Amplitude --- >");
title("Spectrum of input");
subplot(2,1,2); plot(f,abs(sff_f));
xlabel("Frequency --->");
ylabel("Amplitude --- >");
title("Spectrum of slow flat fading");
%%slow and frequency selective
h2=randn+1i*randn;
sfs=(h1.*x1)+(h2.*x2);
sfs_f=fft(sfs);
figure()
subplot(2,1,1)
plot(f,abs(x1_f));
xlabel("Frequency --->");
ylabel("Amplitude --- >");
title("Spectrum of input");
subplot(2,1,2)
plot(f,abs(sfs_f));
xlabel("Frequency --->");
ylabel("Amplitude --- >");
title("Spectrum of slow frequency selective fading");
% fast and flat fading
fc=1;
00;
n1=(randi([0 1],1,length(x1))+1i*randi([0 1],1,length(x1)));
figure()
subplot(2,1,1)
plot(t,n1)
xlabel("time--->");
ylabel("Amplitude --- >");
title("Gaussian noise");
[b,a] = butter(6,fc/(fs/2)) ; % Butterworth filter of order 6
fx1 = filter(b,a,n1); % Will be the filtered signal
ff1=x1.*fx1;
ff_f=fft(ff1);
subplot(2,1,2)
plot(f,abs(ff_f));
xlabel("Frequency --->");
ylabel("Amplitude --- >");
title("Spectrum of fast flat fading");
%%fast frequency selective fading
n2=(randi([0 1],1,length(x1))+1i*randi([0 1],1,length(x1)));
[b,a] = butter(6,fc/(fs/2)); % Butterworth filter of order 6
fx2 = filter(b,a,n2); % Will be the filtered signal
ff2=x2.*fx2; ffs=ff1+ff2; ffs_f=fft(ffs);
figure()
plot(abs(ffs_f));
xlabel("Frequency --->");
ylabel("Amplitude --- >");
title("Spectrum of fast frequency selective fading");