function [ out ] = dilation( sig,w,mode )
if mode == 0
     windowSize = w;
    fil = zeros(1,windowSize);
    for i = 1:windowSize
        fil(i) = windowSize;
    end
    hank_Signal = hankel(sig);
    h_Horizontal = hank_Signal(:,1:windowSize);
    [H,W] = size(h_Horizontal);
    for h = 1:H
        h_Horizontal(h,:) = h_Horizontal(h,:)+fil;
    end
    out = max(h_Horizontal, [], 2);
end
if mode == 1
    windowSize = w;
    fil = zeros(1,windowSize);
    for i = 1:ceil(windowSize/2)
        fil(i) = i*windowSize/2;
        fil(windowSize + 1 - i) = i*windowSize/2;
    end
    hank_Signal = hankel(sig);
    h_Horizontal = hank_Signal(:,1:windowSize);
    [H,W] = size(h_Horizontal);
    for h = 1:H
        h_Horizontal(h,:) = h_Horizontal(h,:)+fil;
    end
    out = max(h_Horizontal, [], 2);
end
if mode == 2
   windowSize = w;
    fil = zeros(1,windowSize);
    for i = 1:ceil(windowSize/2)
        fil(i) = sqrt((windowSize/2)^2-(windowSize/2-i)^2);
        fil(windowSize + 1 - i) = sqrt((windowSize/2)^2-(windowSize/2-i)^2);
    end
    hank_Signal = hankel(sig);
    h_Horizontal = hank_Signal(:,1:windowSize);
    [H,W] = size(h_Horizontal);
    for h = 1:H
        h_Horizontal(h,:) = h_Horizontal(h,:)+fil;
    end
    out = max(h_Horizontal, [], 2);
end
end

