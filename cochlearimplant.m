% Convolution-Based Audio Enhancement for Cochlear Implants (Self-contained)

clc;
clear;
close all;

% Sampling parameters
Fs = 16000;              % Sampling frequency
t = 0:1/Fs:2;            % 2 seconds time vector

% Simulated speech-like signal (sum of frequencies)
audio = sin(2*pi*500*t) + 0.5*sin(2*pi*1500*t) + 0.3*sin(2*pi*4000*t);

% Add noise
audio = audio + 0.4*randn(size(audio));

% FIR bandpass filter design (speech frequencies 300–3400 Hz)
N = 80;                           % Filter order
low = 300/(Fs/2);                 
high = 3400/(Fs/2);
b = fir1(N,[low high],'bandpass');

% Apply convolution
enhanced_audio = conv(audio,b,'same');

% Normalize
enhanced_audio = enhanced_audio/max(abs(enhanced_audio));

% Plot results
figure;

subplot(3,1,1)
plot(t,audio)
title('Original Noisy Audio Signal')
xlabel('Time (s)')
ylabel('Amplitude')

subplot(3,1,2)
stem(b)
title('FIR Filter Coefficients')

subplot(3,1,3)
plot(t,enhanced_audio)
title('Enhanced Audio Signal After Convolution')
xlabel('Time (s)')
ylabel('Amplitude')

% Play sounds
disp('Playing Original Audio...')
sound(audio,Fs)
pause(3)

disp('Playing Enhanced Audio...')
sound(enhanced_audio,Fs)