function [ index_for_real_cut_V] = NFindLocalMaximum_right2left( open_project_Vertical,index_start,index_stop,max1,indexmax)

for n = index_start-2:-1:index_stop
    if open_project_Vertical(n) <=  open_project_Vertical(n+1) && (open_project_Vertical(n+2)-open_project_Vertical(n)>=0*max1)&&(open_project_Vertical(n) > max1*0.9)
        index_for_real_cut_V = n+1;
        break
    end
end

if n == index_stop
    index_for_real_cut_V = indexmax;
end

if index_for_real_cut_V == 179
    a=[open_project_Vertical(index_for_real_cut_V-2) open_project_Vertical(index_for_real_cut_V-1) open_project_Vertical(index_for_real_cut_V) open_project_Vertical(index_for_real_cut_V+1) ];
elseif index_for_real_cut_V == 180
    a=[open_project_Vertical(index_for_real_cut_V-2) open_project_Vertical(index_for_real_cut_V-1) open_project_Vertical(index_for_real_cut_V) ];
elseif index_for_real_cut_V == 2
    a=[-1  open_project_Vertical(index_for_real_cut_V-1) open_project_Vertical(index_for_real_cut_V) ];
elseif index_for_real_cut_V == 1
    a=[-1 -1 open_project_Vertical(index_for_real_cut_V) ];
else
    a=[open_project_Vertical(index_for_real_cut_V-2) open_project_Vertical(index_for_real_cut_V-1) open_project_Vertical(index_for_real_cut_V) open_project_Vertical(index_for_real_cut_V+1) open_project_Vertical(index_for_real_cut_V+2)];
end

v=find(a==max(a));
v=v(1);
index_for_real_cut_V=index_for_real_cut_V+v-3;




end

