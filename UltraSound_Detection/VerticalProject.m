function [ project_intensity_Vertical ] = VerticalProject( im_rect)

[endph,endpw] = size(im_rect);

for w = 1:endpw
    project_intensity_Vertical(w) = sum(im_rect(1:endph,w));
end
end

