function [y] = sigshift(x,L,k)
for n =  1:L
    y(n+k) = x(n);
end
end