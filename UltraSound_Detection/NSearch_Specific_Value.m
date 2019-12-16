function [ out,width,mean ] = NSearch_Specific_Value( input,index)
%% This function searchs the specific value in projection plot
n = 1;
L = length(input);
s=0;

threshold =  0.9*input(index);
input(L+1)=input(L);

IND_M = index;

if IND_M==1
    seg(n)=1;
    n=n+1;
end

for l = IND_M:-1:3
    if (input(l)<threshold)||(input(l)-input(l-2)<0) 
        seg(n) = l;
        n = n+1;
        break;
    end
end

if n~=2
    seg(n)=1;
    n=n+1;
end

for l = IND_M:1:L-2
    if (input(l)<threshold)||(input(l)-input(l+2)<0)
        seg(n) = l;
        s=1;
            break;
    end
end

if s~=1
    seg(n)=180;
end

out = seg;
width = abs(out(2)-out(1));
