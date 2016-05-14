function ReportGen1(FileName, Rois,S, CorrMat)
%ReportGen1(FileName, Rois,S, CorrMat,WithinC, BetweenC, MeanW, MeanB, MeanA, MeanE)
NofModule = size(S.ModuleBetween,2);
MeanW = [];
MeanB = [];
MeanA = [];
MeanE = [];

for s = 1 : NofModule
    MeanW = [MeanW S.MeanWithin{1,s}];
    MeanB = [MeanB S.MeanBetween{1,s}];
    MeanA = [MeanA S.MeanAll{1,s}];
    MeanE = [MeanE S.MeanEachRegion{1,s}];
end
page = 1 ;
xlswrite(FileName,Rois,page,'B1')
xlswrite(FileName,Rois',page,'A2')
xlswrite(FileName,CorrMat,page,'B2')
s1 = size (Rois,2);
location1 = ['A' num2str(s1+3)];
MName0 = {'MeanCorr';'MeanCorr_W';'MeanCorr_B';'MeanCorr_all'};
xlswrite(FileName,MName0,page,location1)
location2 = ['B' num2str(s1+3)];
M = [MeanE; MeanW; MeanB; MeanA];
xlswrite(FileName,M,page,location2)
l4 = s1+8;
empty1 = {[],[],[],[]};
Summary_Name1 = {};
Summary_Name21 = {'Avg_W','Avg_B','MeanCorr_W','MeanCorr_B','MeanCorr_all'};
Summary_Name2 = {};
location8 = ['A', num2str(l4+S.MaxModule+2)];
location9 = ['A', num2str(l4+S.MaxModule+3)];
location10 = ['A', num2str(l4+S.MaxModule+4)];
Summary = [];
total = 0;
for i = 1 : NofModule
    colletter = {'A','G','M','S','Y','AE','AK','AQ','AW','BC','BI','BO','BU','CA'};
    colletter2 = {'B','H','N','T','Z','AF','AJ','AR','AX','BD','BJ','BP','BV','CB'};
    MName1 = ['Module_' num2str(i)];
    MName2 = {MName1,'Within','Between','Within%','Between%'};
    ll = S.ROI{1,i}';
    MName3 = {ll{:,:},'Total Possible'}; MName3 = MName3';
    SizeRoi = [S.J(i)-1 s1-S.J(i)];
    W = [S.WCount{1,i};S.BCount{1,i}];W = W';
    %W1 = [W;SizeRoi];
    PW1 = W(:,1)/(SizeRoi(1,1));
    PW2 = W(:,2)/(SizeRoi(1,2));
    PW = [PW1 PW2];
    W2 = [W PW];
    Summary_Name1 = {Summary_Name1{:,:},MName1,empty1{:,:}};
    Summary_Name2 = {Summary_Name2{:,:},Summary_Name21{:,:}};
    MeanBwithoutZero = S.MeanBetween{1,i};
    MeanBwithoutZero = MeanBwithoutZero(~(MeanBwithoutZero==0));
    %Summary = [Summary mean(W(:,1))/SizeRoi(1) mean(W(:,2))/SizeRoi(2) mean(S.MeanWithin{1,i}) mean(S.MeanBetween{1,i}) mean(S.MeanEachRegion{1,i})];
    Summary = [Summary mean(W(:,1))/SizeRoi(1) mean(W(:,2))/SizeRoi(2) mean(S.MeanWithin{1,i}) mean(MeanBwithoutZero) mean(S.MeanEachRegion{1,i})];
    location4 = [colletter{i}, num2str(l4)];
    location5 = [colletter{i}, num2str(l4+1)];
    location6 = [colletter2{i}, num2str(l4+1)];
    location7 = [colletter2{i}, num2str(l4+S.J(i)+1)];

    xlswrite(FileName,MName2,page,location4);
    xlswrite(FileName,MName3,page,location5);
    xlswrite(FileName,W2,page,location6);  
    xlswrite(FileName,SizeRoi,page,location7);  
    total = total+sum(W(:,1))+sum(W(:,2));

end
Summary_Name2 = {Summary_Name2{:,:},'Total'};
Summary = [Summary total];
xlswrite(FileName,Summary_Name1,page,location8);  
xlswrite(FileName,Summary_Name2,page,location9);
xlswrite(FileName,Summary,page,location10)





