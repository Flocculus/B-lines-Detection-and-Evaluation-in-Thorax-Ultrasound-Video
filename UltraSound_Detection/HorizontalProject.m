function [out] = HorizontalProject(input)
%% This function project the rectified image along horizontal axis

[H,W] = size(input);
for i = 1:H
  out(i) = sum(input(i,270:470))/201;
end