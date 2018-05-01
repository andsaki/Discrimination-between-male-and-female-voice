clear all
close all
clc
%%データの読み込み
cd('voice_analysis')
name = dir('*.m4a');
cd('..')
%%短時間エネルギーの計算とmat作成
for ando_1 = 1:length(name)
    cd('voice_analysis')
    wav_name = name(ando_1).name;
    [y,fs] = audioread(wav_name);
    [~,name4] = fileparts(wav_name);
    t=(0:length(y)-1)/fs;
    S = round(0.01*fs);
    N = round(0.03*fs);
    [a,b] = size(y);
    n = (a-N)/S;
    E = zeros(1,uint8(n));
    for x = 1:n
        p = 0;
        for m = x*S+1:x*S+N
            p = p + y(m).^2;
        end
    E(x) = p;
    end
    plot(E)
    cd('../voice_power');
    save([name4,'_p.mat'])
    cd('..')
end