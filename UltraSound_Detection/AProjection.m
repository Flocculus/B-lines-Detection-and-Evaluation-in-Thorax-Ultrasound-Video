function [output]=AProjection(input1,input2,input3)
k=1;
mapm=[];
for i=input3(1)+1:input3(2)-1
    if (input2(i,400)==255)&&(input2(i,401)==255);
        mapm(k,:)=input1(i-input3(1)+1,:);
        k=k+1;
    end
end
%if k==1
%    for i=input3(1):input3(2)
%        mapm(k,:)=input1(i-input3(1)+1,:);
%        k=k+1;
%    end
%end




[h,w]=size(mapm);
output=zeros(1,w-5);
if h~=0
    for i=1:w-5
        output(i)=sum(mapm(:,i))/h;
    end
else 
    output=0;
end

