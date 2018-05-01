clear all
close all
clc
%%matƒf[ƒ^‚Ì“Ç‚İæ‚è
cd('voice_analysis');
name_f = dir('*.mat');
lady =[3,4,5,9,11,12,13,15,16,20];
man = [1,2,6,7,8,10,14,17,18,19];
%%—«‚Ìº‚Ì‚‚³‚Ì“Á’¥—Ê
for ii = 1:length(lady)
    load(name_f(lady(ii)).name);
    f0(f0==0) = [];
    lady_mean(ii) = mean(f0);
    lady_medi(ii) = median(f0);
end
%%—«‚Ìº‚Ì‚‚³‚Ì“Á’¥—Ê
for ii = 1:length(man)
    load(name_f(man(ii)).name);
    f0(f0==0) = [];
    man_mean(ii) = mean(f0);
    man_medi(ii) = median(f0);
end
%%plot
figure
plot(lady_mean,lady_medi,'mo','Markersize',10,'Linewidth',5)
hold on
plot(man_mean,man_medi,'bo','Markersize',10,'Linewidth',5)
grid on
cd('../mat')
save('f0.mat')
cd('..')

