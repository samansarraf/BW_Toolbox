close all
clear all
clc
%%
J = load('C:\Users\ssarraf\Desktop\Codes\Emotion\Females\CONN\resultsROI_Condition001_conn_females_162.mat');
rawdata = J.Z;
filename = 'C:\Users\ssarraf\Desktop\Codes\Emotion\Females\CONN\all_cor_females.xlsx';
I = rawdata;
N = [];
s = size(rawdata,1);
for ii = 1 : size(I,3)
    M = I(:,1:s,ii);
    N = [N;M];
end
N(isnan(N)) = 0;
xlswrite(filename,N,1,'B2')

