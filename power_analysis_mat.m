clear all
close all
clc
%%matデータの読み取り
cd('voice_power');
name_f = dir('*.mat');
lady =[3,4,5,9,11,12,13,15,16,20];
man = [1,2,6,7,8,10,14,17,18,19];
%%女性の声の大きさの特徴量
for ii = 1:length(lady)
    load(name_f(lady(ii)).name);
    E = E/max(E);
    E = 10 * log10(E);
    lady_diff_4(ii) = max(diff(E(E>=-25),4));
    lady_diff_3(ii) = max(diff(E(E>=-25),3));
figure
    E(E<=-25) = [];

    lady_mean(ii) = mean(E);
    lady_var(ii) = var(E);
end
%%男性の声の大きさの特徴量
for ii = 1:length(man)
    load(name_f(man(ii)).name);
    E = E/max(E);
    E = 10 * log10(E);
    man_diff_4(ii) = max(diff(E(E>=-25),4));
    man_diff_3(ii) = max(diff(E(E>=-25),3));
    E(E<=-25) = [];
    man_mean(ii) = mean(E);
    man_var(ii) = var(E);
end
%%plot
figure;
plot(lady_diff_3,lady_diff_4,'mo','Markersize',10,'Linewidth',5)
hold on
plot(man_diff_3,man_diff_4,'bo','Markersize',10,'Linewidth',5)
grid on
cd('../mat')
save('energy.mat')
cd('..')

