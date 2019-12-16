function [ output,restout ] = Segmentation_Pleural_B( input,index,plemax )
%% This function segment the input image by index along axis
% input: Image which is to be segmented
% index: position that is cutted
% axis: orientation that cut (0: vertically 1:horizontally)

[H,W] = size(input);
output = uint8(zeros(H,W));
%%

% for h = 1:H
%     for w = plemax-20:index(2)
%         output(h,w) = input(h,w);
%     end
% end

for h = 1:H
    for w = index(1):index(2)
        output(h,w) = input(h,w);
    end
end


restout =  uint8(zeros(H,W));
%if index(2)>250
%    index(2)=250;
%end
for h = 1:H
    for w = index(2):W
        restout(h,w) = input(h,w);
    end
end
end

