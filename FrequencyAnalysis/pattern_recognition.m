%{ ���������� ������� �������������. %}
sampling_frequency = 50000;

%{ ������� ��������� ������ ������������������ � 0.5 �������. %}
time = (0:1/sampling_frequency:0.5)';

%{ ������ ������������ ��� �������. %}
frequency_1 = 21000;
frequency_2 = 18000;

%{ ����������� ��� ���������� �����. %}
square_wave_1 = (square(frequency_1 * 2 * pi * time, 50) + 1) * 0.5;
square_wave_2 = (square(frequency_2 * 2 * pi * time, 50) + 1) * 0.5;

%{ ������������� �������� ����� ���� ��� ��������� ������ �������. %}
square_wave_3 = [...
    square_wave_1(1:sampling_frequency/4);...
    square_wave_2(sampling_frequency/4+1:sampling_frequency/2+1)];

%{ ������� ���� ��� ������ �����. %}
scope_1 = dsp.TimeScope(...
    'Name', '21kHz square wave',...
    'SampleRate',sampling_frequency,...
    'TimeSpan',0.5);

scope_2 = dsp.TimeScope(...
    'Name', '18kHz square wave',...
    'SampleRate',sampling_frequency,...
    'TimeSpan',0.5);

scope_3 = dsp.TimeScope(...
    'Name', '21+18kHz square wave',...
    'SampleRate',sampling_frequency,...
    'TimeSpan',0.5);

%{ �������� ����� � �����. %}
scope_1(square_wave_1);
scope_2(square_wave_2);
scope_3(square_wave_3);

%{
    ��������� ����� ������ ������� ����� ���� ������� numberOfSamples
    ��� ������� ��������.
%}

i = 1;
numberOfSamples = 6;

while i + numberOfSamples <= sampling_frequency / 2 + 1
    pattern = square_wave_3(i:i+numberOfSamples-1)
    
    i = i + numberOfSamples;
end

    

