clear all
close all
clc
%%音声データを読み込む
cd('voice_analysis');
name = dir('*.m4a'); 
%%f0の計算とmat作成
for ando = 1:length(name)
    wav_name = name(ando).name;
    [y,fs] = audioread(wav_name);
    [~,name2] = fileparts(wav_name);
    y = resample(y(:,1),8000,fs);
    fs = 8000;
    %%BPF
    low = 50;
    high = 500;
    a = 1;
    b = fir1(100,[low/(fs/2) high/(fs/2)]);
    y = filter(b,a,y);
    %%frame処理
    yframe=y(frameindex(256,16,length(y)));
    [f,nframe] = size(yframe);
    %%f0
    for i=1:nframe
        xc =xcorr(yframe(:,i));
        [pks,loc] = findpeaks(xc(257:end),'minpeakheight',xc(256)*0.5);
        if isempty(loc)
            f0(i) = nan;
        else
            [v,maxindex]=max(pks);
            f0(i) = loc(maxindex);
        end
    end
    f0(isnan(f0)==1)=0;
    f0 = f0.*(1/fs);
    f0 = 1./f0;
    f0(f0<=low)=0;
    f0(f0>=high) = 0;
    %%smoothing(平滑化)
    f0 = medfilt1(f0,50);
    f0 = smooth(f0,20,'moving');
    f0(f0<=low) = 0;
    f0(f0>=high) =  0;
    %%plot
    figure;
    subplot(211)
    plot(linspace(0,length(y)/fs,length(f0)),f0)
    xlim([0 length(y)/fs])
    subplot(212)
    spectrogram(y,hann(1024),512,1024,fs,'yaxis')
    xlim([0 length(y)/fs])
    save([name2,'.mat'])
end
cd('..')
