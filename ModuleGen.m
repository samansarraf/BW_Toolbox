function [a] = ModuleGen(noModule,zMatrix,J,Rois,Rois2)
s= struct;
M = zeros(noModule,2);
N = zeros(noModule,2);
for m = 1 : noModule
    %s_name = ['s.Module_' num2str(m)];
    if m == 1
        M(m,1) = 1;
        M(m,2) = J(m);
    end
    if m > 1
        M(m,1) = M(m-1,2) + 1;
        M(m,2) = M(m-1,2) + J(m);
    end
    s.ModuleWithin{m} = zMatrix(M(m,1):M(m,2),M(m,1):M(m,2));   
end
for m = 1 : noModule
    if m == 1 
        s.ModuleBetween{m} = zMatrix(M(m+1,1):end,M(m,1):M(m,2));
    end
    if m > 1 
        B1 = zMatrix(M(1,1):M((m-1),2),M(m,1):M(m,2));% first part 
        B2 = zMatrix(M(m,2)+1:end,M(m,1):M(m,2));
        s.ModuleBetween{m} = [B1;B2];
    end
end
for m = 1 : noModule
    s.ROI{m} = Rois2(M(m,1):M(m,2));
end
s.MaxModule = max(J);
s.J = J;
s.M = M;
a = s;

       