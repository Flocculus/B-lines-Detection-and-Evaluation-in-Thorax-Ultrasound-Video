function [output]=Smooth(input,lambda)
%%smooth a matrix
if input==0
    output=zeros(287,1);
else
input=input';
[h,w]=size(input);
D=convmtx([-1 1],h-1);

output=((eye(h)+lambda*(D')*D)^-1)*input;

end