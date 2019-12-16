function [output]=fixBound_pleural_vertical(Bound_pleural_vertical)
%% widen the Bound_pleural to avoid shaking and diffraction

if Bound_pleural_vertical(2)>87
    Bound_pleural_vertical(2)=87;
end

c=ceil(0.1*(Bound_pleural_vertical(2)-Bound_pleural_vertical(1)));

Bound_pleural_vertical=Bound_pleural_vertical+[-c,c];

if Bound_pleural_vertical(2)>87
    Bound_pleural_vertical(2)=87;
end

if Bound_pleural_vertical(1)<1
    Bound_pleural_vertical(1)=1;
end

output=Bound_pleural_vertical;
