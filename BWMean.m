function [MW, MB] = BWAMean(data_w,data_b)
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
    MB = [MB , mean(temp2)];
end
Mean_DAN_all = [];
for i = 1 : 11
    temp = Z1(:,1:11);
    temp(:,i) = 0;
    temp(i,:) = 0;
    [r,c] = find(temp>0);
    temp2 = zeros(size(c,1),1);
    for k = 1 : size(c,1)
        temp2(k,1) = temp(r(k,1),c(k,1));
    end
    Mean_DAN_all = [Mean_DAN_all , mean(mean(temp2))];
end