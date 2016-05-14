clear all
close all
clc
load C:\Users\SaMaN\Documents\Codes\test.mat
load C:\Users\SaMaN\Documents\Codes\BW_toolbox_new\ROIS.mat
I = xlsread('C:\Users\SaMaN\Documents\Codes\BW_toolbox_new\book2.xlsx',2);
J = xlsread('C:\Users\SaMaN\Documents\Codes\BW_toolbox_new\book2.xlsx',3);
K = load ('C:\Users\SaMaN\Documents\Codes\Task\resultsROI_TASK.mat');
n = zeros(size(m));
n = m (I,I);
%Rois = K.names;
[L] = ModuleGen(4,n,J,Rois);
%[WC1,BC1] = BWCount(L.ModuleWithin{1,1},L.ModuleBetween{1,1},0.2);
L = BWCount(L,0.2);
%[MW1, MB1, MA1, MER1] = BWAMean(L.ModuleWithin{1,1},L.ModuleBetween{1,1});
L = BWAMean(L);
%ReportGen1('TestFile.xlsx', Rois,L,m,WC1, BC1, MW1, MB1, MA1, MER1)
ReportGen1('Test4.xlsx',Rois,L,m)
