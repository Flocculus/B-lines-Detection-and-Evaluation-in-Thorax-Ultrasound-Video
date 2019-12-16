function [ out,width ] = Search_Specific_Value_width_pleural( im_rect,input,index_for_real_cut_V,method )
%% This function searchs the specific value in projection plot
n = 1;
L = length(input);
if method == 0
Firstderi = diff(input);
seg_direct(1) = max(find(Firstderi==(max(Firstderi(1+11:L-10)))));
seg_direct(2) = min(find(Firstderi==(min(Firstderi(1+11:L-10)))));
end

if method == 1
median_p = median(input);
mean_p = mean(input);


IND_M = find(input == max(max(input)));
for l = IND_M:-1:1
    if input(l)<mean_p
        seg_direct(n) = l;
        n = n+1;
        break;
    end
end
if n==0
    n=1;
    seg_direct(n) = 1;
end

for l = IND_M:L
    if input(l)<mean_p
        seg_direct(n) = l;
            break;
    end
end

if n==1
    n=2;
    seg_direct(n) = 87;
end

end

%[ seg_index_rg,width_rg ] = Region_Growing(im_rect, index_for_real_cut_V );

width_direct = abs(seg_direct(2)-seg_direct(1));

%if width_rg <= 5/4*width_direct && width_rg > width_direct*3/4
  %  width = width_rg;
  %  out = seg_index_rg;
%else   
    width = width_direct;
    out = seg_direct;
%end


end