clear all
close all
clc
%%短時間エネルギーの特徴量ベクトルの結合
cd('mat')
load('energy.mat')
lady_data = [lady_diff_3;lady_diff_4];
man_data = [man_diff_3;man_diff_4];
%%声の高さの特徴量ベクトルの結合
load('f0.mat')
lady_data = [lady_data;lady_mean;lady_medi]; 
man_data = [man_data;man_mean;man_medi]; 
%%学習データ
lady_data_t = [lady_data(:,2),lady_data(:,4:6),lady_data(:,10)];
man_data_t = [man_data(:,1),man_data(:,3),man_data(:,5:6),man_data(:,8)];
[mean_l,var_l] = normfit(lady_data_t');
[mean_m,var_m] = normfit(man_data_t');
%%テストデータ
test = [[man_data(:,2),man_data(:,4),man_data(:,7),man_data(:,9),man_data(:,10)],[lady_data(:,1),lady_data(:,3),lady_data(:,7:9)]];
[~,num] = size(test);
%%認識率の計算
c1 = 1;
c2 = 1;
c3 = 1;
c4 = 1;
for ii = 1:num
lady_yudo = mvnpdf(test(:,ii)',mean_l,var_l);
man_yudo = mvnpdf(test(:,ii)',mean_m,var_m);
if lady_yudo<=man_yudo
    if ii<=(num/2)
        c1 = c1 + 1;
    else
        c2 = c2 + 1;

    end
else
    if ii>(num/2)+1
        c3 = c3 + 1;

    else
        c4 = c4 + 1;
    end
end
end

disp('==========================')
disp('精度')
(c1+c3)/(c1+c2+c3+c4)
disp('==========================')
