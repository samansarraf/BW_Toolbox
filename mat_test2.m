clear all
close all
clc 
%%
%D = load ('C:\Users\ssarraf\Desktop\SAMAN\Codes_Saman\Codes\Task\resultsROI_TASK.mat');
[FileName,PathName] = uigetfile('*.mat','Select the .mat file');
PathFile = [PathName FileName];
D = load(PathFile);
Rois = D.names;
[FileName,PathName] = uigetfile('*.xls*','Select the excel file');
PathFile = [PathName FileName];
I = xlsread(PathFile,2);
J = xlsread(PathFile,3);
% I = xlsread('C:\Users\ssarraf\Desktop\SAMAN\Codes_Saman\Codes\cheryldata_3net.xlsx',2); % ROIs order
% J = xlsread('C:\Users\ssarraf\Desktop\SAMAN\Codes_Saman\Codes\cheryldata_3net.xlsx',3); % Module Size
nofModule = size(J,1);
L = {[]};
v = ver;
nofSubj = size(D.Z,3);
if any(strcmp('Parallel Computing Toolbox',{v.Name}))
    dataP = D.Z;
    matlabpool
    parfor i = 1 : nofSubj
    data = dataP(:,:,i);
    data(isnan(data)) = 0;
    dataOrdered = data(I,I);
    L{i} = ModuleGen(nofModule,dataOrdered,J,Rois);
    L{i} = BWCount(L{i},0.2);
    L{i} = BWAMean(L{i});
    FileName = ['Subject_' num2str(i),'.xlsx'];
    ReportGen1(FileName,Rois,L{i},data)
    end
    matlabpool close
else
    for i = 1 : nofSubj
    data = D.Z(:,:,i);
    data(isnan(data)) = 0;
    dataOrdered = data(I,I);
    L{i} = ModuleGen(nofModule,dataOrdered,J,Rois);
    L{i} = BWCount(L{i},0.2);
    L{i} = BWAMean(L{i});
    FileName = ['Subject_' num2str(i),'.xlsx'];
    ReportGen1(FileName,Rois,L{i},data)
    end
end
ReportGen2 (L,'Summary_report.xlsx')

    

    
    