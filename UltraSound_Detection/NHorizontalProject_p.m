function [out] = NHorizontalProject_p(input,index_p)
%% This function project the rectified image along horizontal axis

    [H,W] = size(input);
    for i = 1:H
        if index_p-10>=1
        out(i) = sum(input(i,index_p-10:W));
        else
            out(i) = sum(input(i,1:W));
        end
    end
