function [Video] = ABPline(index,indexA,Num_Frame,im)
Xo=20.4665;
Yo=425;
Rmax=480.5335;
Rmin=51.3202;
Rd=1;
Nr=481;
%%%%%预处理
Frame=zeros(Num_Frame,600,1600,3);
 for i=1:Num_Frame
    Frame(i,:,1:800,:) = read(im,i);
    Frame(i,:,801:1600,:) = Frame(i,:,1:800,:);%读取全部帧并复制
 end
 
 indexB=fliplr(index(:,:,1));
 indexP=fliplr(index(:,:,2));
 indexA=indexA';
%%%%%%%B
for i=1:Num_Frame
    for j=21:600
        for k=1:800
            dx= j-Xo;
            dy= k-Yo;
            dr= (dx^2+dy^2)^(1/2);
            theta=round(180*acos(dy/dr)/pi);
            if (theta-46>=1)&&(theta-46<=87)
                if round(dr)<=481;
                if indexB(i,theta-46)==255
                    Frame(i,j,k,2)=255;
                end
                end
            end
            
            
            if (theta-46>=1)&&(theta-46<=87)
                if round(dr)<=481;
                if indexP(i,theta-46)==255
                    Frame(i,j,k,1)=255;
                    
                end
                end
            end
            
            
            if (theta-46>=1)&&(theta-46<=87)
                if round(dr)<=481;
                if indexA(i,round(dr))==255
                    Frame(i,j,k,3)=255;
                end
                end
            end
            
            
        end
    end
end

Video=uint8(Frame);

end