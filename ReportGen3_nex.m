function N = ReportGen3_nex (rawdata,orderofData,rois)
I = rawdata;
N = [];
rois=rois(1,orderofData);
for ii = 1 : size(I,3)
    M = I(:,:,ii);
    M = M(orderofData,orderofData);
    N = [N;M];
end
N(isnan(N)) = 0;
%xlswrite(filename,N,1,'B2')
%xlswrite(filename,rois,1,'B1')

