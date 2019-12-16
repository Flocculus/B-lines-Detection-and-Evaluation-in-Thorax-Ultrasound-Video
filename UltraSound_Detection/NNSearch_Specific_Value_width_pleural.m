function [ out,width ] = NNSearch_Specific_Value_width_pleural(input)
%% This function searchs the specific value in projection plot
n = 1;
L = length(input);

seg_direct=zeros(1,2);
T=max(input);  
IND_M = find(input == max(max(input)));

for i=IND_M:-1:1
    seg_direct(1)=i;
    if input(i)<0.6*T
        break;
    end
end

for i=IND_M:1:L
    seg_direct(2)=i;
    if input(i)<0.6*T
        break;
    end
end





width_direct = abs(seg_direct(2)-seg_direct(1));

width = width_direct;
out = seg_direct;



end