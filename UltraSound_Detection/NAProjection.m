function [output]=NAProjection(Aarea,map,num)
[H,W]=size(Aarea);
output=zeros(1,W);
for i=1:W
    for j=1:H
        if map(num,j,1)==255
            output(i)=output(i)+Aarea(j,i);
        end
    end
end
N=0;
for i=1:H
    if map(num,i,1)==255;
        N=N+1;
    end
end
if N~=0
    output=output/N;
end
end

