function [ output ] = GrayScale(input)
[~,W]=size(input);
output=zeros(1,512);
for i=1:W
    for j=1:512
        if (input(i)<=j)&&(input(i)>=j-1)
            output(j)=output(j)+1;
        end
    end
end

end