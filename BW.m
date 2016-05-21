function BW(nex)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                                                                     %%%
%%%                                                                     %%%
%%% B/W Toolbox - A Graph Analysis Method                               %%%
%%% Saman Sarraf - 2015                                                 %%%
%%% samansarraf@ieee.org                                                %%%
%%% ssarraf.rotman@gmail.com                                            %%%
%%% https://github.com/samansarraf/BW_Toolbox.git                       %%%
%%%                                                                     %%%
%%% Syntax:                                                             %%% 
%%%    BW                                                               %%% 
%%%    BW noexcel                                                       %%% 
%%%    BW summary                                                       %%% 
%%%                                                                     %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc 
%%
addpath(fileparts(which('BW.m')))
prompt = 'Please Enter the Threshold ( 0.2 is a good choice ) => ';
x = input(prompt,'s');
thresh = str2double(x);
folder_name = uigetdir('','Select the output folder');
cd (folder_name);
[FileName,PathName] = uigetfile('*.mat','Select the .mat file inclduing correlation values');
PathFile = [PathName FileName];
D = load(PathFile);
Rois = D.names;
[FileName,PathName] = uigetfile('*.xls*','Select the excel file');
PathFile = [PathName FileName];
prompt = 'Parallel Computing Toolbox ? Enter 1 : Yes or 2 : No => ';
parallel_f = input(prompt,'s');
parallel_flag = str2double(parallel_f);

I = xlsread(PathFile,2);
J = xlsread(PathFile,3);
sr = size(I,1);
nofModule = size(J,1);
L = {[]};
v = ver;
nofSubj = size(D.Z,3);
D.Z = D.Z(1:sr,1:sr,1:nofSubj);
Rois = Rois(1,1:sr);
Rois2 = Rois(1,I);
if nargin < 1 
    nex = 'empty';
end

%%%%%%%%%%%%% No Excel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(nex,'noexcel')
    if parallel_flag == 1
        
        if any(strcmp('Parallel Computing Toolbox',{v.Name}))
            disp('Calculating Metrics & Generating Reports ...')
            dataP = D.Z;
            matlabpool
            parfor i = 1 : nofSubj
                data = dataP(:,:,i);
                data(isnan(data)) = 0;
                dataOrdered = data(I,I);
                L{i} = ModuleGen(nofModule,dataOrdered,J,Rois,Rois2);
                L{i} = BWCount(L{i},thresh);
                L{i} = BWAMean(L{i});
                FileName = ['Subject_' num2str(i),'.xlsx'];
                ReportGen1_nex(Rois2,L{i},dataOrdered)
                end
                matlabpool close
        end
    else
        h = waitbar(0,'Calculating Metrics & Generating Reports ...');
        for i = 1 : nofSubj
            waitbar (i/nofSubj,h)  
            data = D.Z(:,:,i);
            data(isnan(data)) = 0;
            dataOrdered = data(I,I);
            L{i} = ModuleGen(nofModule,dataOrdered,J,Rois,Rois2);
            L{i} = BWCount(L{i},thresh);
            L{i} = BWAMean(L{i});
            FileName = ['Subject_' num2str(i),'.xlsx'];
            ReportGen1_nex(Rois2,L{i},dataOrdered)
        end
        close(h)
    end
    disp('Summary...')
    ReportGen2_nex (L) %Summary
    disp('Extracting Correlation values for all subjects ...')
    All_Corr = ReportGen3_nex (D.Z,I,Rois2);%All correlation matrices in one excel file
    save('BW_results.mat','L','All_Corr')
    disp('B/W Analysis is done successfully!')
    
    
elseif strcmp(nex,'summary')
    if parallel_flag == 1
        if any(strcmp('Parallel Computing Toolbox',{v.Name}))
            disp('Calculating Metrics & Generating Reports ...')
            dataP = D.Z;
            matlabpool
            parfor i = 1 : nofSubj
                data = dataP(:,:,i);
                data(isnan(data)) = 0;
                dataOrdered = data(I,I);
                L{i} = ModuleGen(nofModule,dataOrdered,J,Rois,Rois2);
                L{i} = BWCount(L{i},thresh);
                L{i} = BWAMean(L{i});
                FileName = ['Subject_' num2str(i),'.xlsx'];
                ReportGen1_nex(Rois2,L{i},dataOrdered)
            end
            matlabpool close
        end     
    else
        h = waitbar(0,'Calculating Metrics & Generating Reports ...');
        for i = 1 : nofSubj
            waitbar (i/nofSubj,h)  
            data = D.Z(:,:,i);
            data(isnan(data)) = 0;
            dataOrdered = data(I,I);
            L{i} = ModuleGen(nofModule,dataOrdered,J,Rois,Rois2);
            L{i} = BWCount(L{i},thresh);
            L{i} = BWAMean(L{i});
            FileName = ['Subject_' num2str(i),'.xlsx'];
            ReportGen1_nex(Rois2,L{i},dataOrdered)
       end
        close(h)
    end
    disp('Summary...')
    ReportGen2 (L,'Summary_report.xlsx') %Summary
    disp('Extracting Correlation values for all subjects ...')
    All_Corr = ReportGen3 (D.Z,I,Rois2,'CorrMat_allsubjects.xlsx');%All correlation matrices in one excel file
    save('BW_results.mat','L','All_Corr')
    disp('B/W Analysis is done successfully!')
    
else

    if parallel_flag == 1
        if any(strcmp('Parallel Computing Toolbox',{v.Name}))
            disp('Calculating Metrics & Generating Reports ...')
            dataP = D.Z;
            matlabpool
            parfor i = 1 : nofSubj
            data = dataP(:,:,i);
            data(isnan(data)) = 0;
            dataOrdered = data(I,I);
            L{i} = ModuleGen(nofModule,dataOrdered,J,Rois,Rois2);
            L{i} = BWCount(L{i},thresh);
            L{i} = BWAMean(L{i});
            FileName = ['Subject_' num2str(i),'.xlsx'];
            ReportGen1(FileName,Rois2,L{i},dataOrdered)
            end
            matlabpool close
        end     
    else
        h = waitbar(0,'Calculating Metrics & Generating Reports ...');
        for i = 1 : nofSubj
        waitbar (i/nofSubj,h)  
        data = D.Z(:,:,i);
        data(isnan(data)) = 0;
        dataOrdered = data(I,I);
        L{i} = ModuleGen(nofModule,dataOrdered,J,Rois,Rois2);
        L{i} = BWCount(L{i},thresh);
        L{i} = BWAMean(L{i});
        FileName = ['Subject_' num2str(i),'.xlsx'];
        ReportGen1(FileName,Rois2,L{i},dataOrdered)
        end
        close(h)
    end
    disp('Summary...')
    ReportGen2 (L,'Summary_report.xlsx') %Summary
    disp('Extracting Correlation values for all subjects ...')
    All_Corr = ReportGen3 (D.Z,I,Rois2,'CorrMat_allsubjects.xlsx');%All correlation matrices in one excel file
    save('BW_results.mat','L','All_Corr')
    disp('B/W Analysis is done successfully!')
end
end