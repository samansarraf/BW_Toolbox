function [S] = BWAMean(S)
for s = 1 : size(S.ModuleBetween,2)
    data_w = S.ModuleWithin{1,s};
    data_b = S.ModuleBetween{1,s};
    A = data_w;
    MW = [];
    for i = 1 : size(data_w,2)
        temp = A(:,i);
        %for j = 1 : size(data_w,1)
            [r,c] = find(temp>0);
            temp2 = zeros(size(c,1),1);
            for k = 1 : size(c,1)
                temp2(k,1) = temp(r(k,1),c(k,1));
            end
        %end      
        if isnan(mean(temp2))
            temp2 = 0; 
        end    
    MW = [MW , mean(temp2)];
    end
    MB = [];
    B = data_b;
    for i = 1 : size(data_b,2)
        temp = B(:,i);
        %for j = 1 : size(data_b,1)
            [r,c] = find(temp>0);
            temp2 = zeros(size(c,1),1);
            for k = 1 : size(c,1)
                temp2(k,1) = temp(r(k,1),c(k,1));
            end
        %end
        if isnan(mean(temp2))
           temp2 = 0; 
        end
        MB = [MB , mean(temp2)];
    end
    MA = [];
    C = [data_w ; data_b];
    for i = 1 : size(data_w,2)
        temp = C;
        temp(:,i) = 0;
        temp(i,:) = 0;
        [r,c] = find(temp>0);
        temp2 = zeros(size(c,1),1);
        for k = 1 : size(c,1)
            temp2(k,1) = temp(r(k,1),c(k,1));
        end
        if isnan(mean(temp2))
            temp2 = 0; 
        end   
        MA = [MA , mean(mean(temp2))];
    end
    MER = zeros(1,size(C,2)); % Mean Each Region
    for i = 1 : size(C,2)
        temp1 = C(:,i);
        [r,c] = find(temp1>0);
        temp = zeros(1,size(c,1));
        for j = 1 : size(c,1)
            temp(1,j) = temp1(r(j,1),c(j,1));
        end
        MER (1,i) = mean(temp);
    end
    % MW, MB, MA, MER
    S.MeanWithin{s} = MW;
    S.MeanBetween{s} = MB;
    S.MeanAll{s} = MA;
    S.MeanEachRegion{s} = MER;
    
end