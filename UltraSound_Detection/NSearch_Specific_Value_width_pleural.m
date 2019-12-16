function [ out,width ] = NSearch_Specific_Value_width_pleural( im_rect,input,index_for_real_cut_V,method )
%% This function searchs the specific value in projection plot
n = 1;
L = length(input);
map=zeros(L,1);
map1=zeros(L,1);
map2=zeros(L,1);
median_p = median(input);
mean_p = mean(input);
seg_direct=zeros(1,2);

for i=1:L
    if input(i)>=mean_p
        map(i)=1;
    end
end


for i=1:(method/2-1)
    if sum(map(1:i+method/2))>0
        map1(i)=1;
    end
end

for i=(L-method/2+1:L)
    if sum(map(i-method/2:L))>0
        map1(i)=1;
    end
end

for i=(method/2+1):(L-method/2)
    if sum(map(i-method/2:i+method/2))>0
        map1(i)=1;
    end
end
    



for i=1:(method/2)
    if sum(map1(1:i+method/2))==(i+method/2)
        map2(i)=1;
    end
end

for i=(L-method/2+1:L)
    if sum(map1(i-method/2:L))==(10-i+method/2+1)
        map2(i)=1;
    end
end

for i=(method/2+1):(L-method/2)
    if sum(map1(i-method/2:i+method/2))==method+1
        map2(i)=1;
    end
end
    
IND_M = find(input == max(max(input)));

for i=IND_M:-1:1
    if map2(i)==0
        seg_direct(1)=i;
        break
    end
end

if seg_direct(1)==0
    seg_direct(1)=1;
end

for i=IND_M:L
    if map2(i)==0
        seg_direct(2)=i;
        break
    end
end

if seg_direct(2)==0
    seg_direct(2)=L;
end


width_direct = abs(seg_direct(2)-seg_direct(1));

width = width_direct;
out = seg_direct;



end