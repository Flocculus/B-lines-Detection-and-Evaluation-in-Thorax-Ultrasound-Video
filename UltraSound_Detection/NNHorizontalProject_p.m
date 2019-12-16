function [out] = NNHorizontalProject_p(input,index_p)
%% This function project the rectified image along horizontal axis

    [H,W] = size(input);

    for i = 1:H
        
        out(i) = sum(input(i,1:W));

    end
