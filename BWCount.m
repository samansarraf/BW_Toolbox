function [S] = BWCount(S,thresh)
for s = 1 : size(S.ModuleBetween,2)
    data_w = S.ModuleWithin{1,s};
    data_b = S.ModuleBetween{1,s};
    Within = zeros(1,size(data_w,2));
    Between = zeros(1,size(data_b,2));
    for j = 1 : size(data_w,2)
        for i = 1 : size(data_w,1)
            if data_w(i,j) >= thresh
                Within(1,j) = Within(1,j) + 1;
            end
        end
        for k = 1 : size(data_b,1) 
            if data_b(k,j) >= thresh
                Between(1,j) = Between(1,j) +1;
            end
        end
    end
    S.WCount{s} = Within;
    S.BCount{s} = Between;
end