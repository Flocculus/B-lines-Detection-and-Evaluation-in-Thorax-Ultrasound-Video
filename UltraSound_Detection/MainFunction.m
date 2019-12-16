% input a video, the output will be the same video with the marks of
% A-lines Blines and Pleural lines
%The function with "N" means new it can be ignored
Rate=zeros(48,8);
for filenum = 45:48
mydir=['E:\Dropbox\Dropbox\GabeCHF\study',num2str(filenum),'\'];
filenames=dir([mydir,'*.mp4']);

for n=1:8
    filenum
    n
filename=[mydir,filenames(n).name];
im = VideoReader(filename);
Num_Frame = im.NumberOfFrames;
vidHeight = im.Height;
vidWidth = im.Width;
 map=zeros(Num_Frame,87,3);%ABPmap,,1b 2p 3a
 map2=zeros(Num_Frame,180);
 map3=zeros(Num_Frame,1);
 map4=zeros(481,Num_Frame);
 
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5%%%%%%%%%%%%%%%%%%%%%preprocessing%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 im_rect=zeros(Num_Frame,87,481);
 for i=1:Num_Frame
    image = rgb2gray(read(im,i));%to gray image
    im_rect(i,:,:) =Im2RectN(im2uint8(image));% to rectangular
 end
 
 Aveim_rect=sum(im_rect,1)/Num_Frame;
 Sol(:,:)=Aveim_rect(1,:,:);
 
 [noisemap] = NNHorizontalProject_p(Sol(1:87,370:470))/101;
 Sol=Sol-min(noisemap);
    
 project_intensity_Vertical = VerticalProject(Sol);%projection
 dilation_project_Vertical = dilation(project_intensity_Vertical, 5,2);%dilation
 close_project_Vertical = erosion(dilation_project_Vertical, 5,2);%erosion
 close_project_Vertical = sigshift(close_project_Vertical,length(close_project_Vertical),5);%shift
 close_project_Vertical(1:5)=project_intensity_Vertical(1:5);%compensate

 [peak ,index_for_P] = max(close_project_Vertical(1:180));%find the max value in first 180 pixels
 [index_for_real_cut_V] = NFindLocalMaximum_right2left( close_project_Vertical,180,2,peak,index_for_P );%Find local peak from 180 to 2, if local peak is too small, change the output to global peak
 [ Bound_pleural,length_Pleural_line ] = NSearch_Specific_Value( close_project_Vertical(1:180),index_for_real_cut_V );%find the width of pleural
 [ First_pleural_seg,~] = Segmentation_Pleural_B(Sol,Bound_pleural,index_for_real_cut_V);%segmentation
 Project_intensity_Horizontal_1_PleuralArea = NNHorizontalProject_p(First_pleural_seg,index_for_real_cut_V);%projection  
 [ Bound_pleural_vertical,width_pleural] = NNSearch_Specific_Value_width_pleural(Project_intensity_Horizontal_1_PleuralArea);%Find the width of pleural space
 Bound_pleural_vertical=fixBound_pleural_vertical(Bound_pleural_vertical);%extend the width of pleural by multiply 120%
 
 [H,W]=size(Sol(:,1:180));
 y=reshape(Sol(:,1:180),1,H*W);
 y1=sort(y,'descend');
 y2=y1(uint16(H*W*0.01)); %get the intensity value of brightest area
    
   Bmap=zeros(Num_Frame,Bound_pleural_vertical(2)-Bound_pleural_vertical(1)+1);
   
 
 
for i = 1:Num_Frame-10

    frame(:,:)=im_rect(i,:,:);
    [noisemap] = NNHorizontalProject_p(frame(1:87,370:470))/101;
    noise=sort(noisemap,'descend');
    frame=frame-noise(80); % find the lowest value and use it to denoising
   
  
    
    %%%%%%%%%%%%%%%%%%%% Bline area searching    

    Bline_Area = zeros(87,481);
    Bline_Area(:,index_for_real_cut_V:end) = frame(:,index_for_real_cut_V:end);
    Bline_Area_new = Bline_Area(Bound_pleural_vertical(1):Bound_pleural_vertical(2),:);
    Project_intensity_Horizontal_1_BlineArea = HorizontalProject(Bline_Area_new);%projection from 270 to 470
    

    %x=GrayScale(Project_intensity_Horizontal_1_BlineArea);%grayscale
    %Pleural=First_pleural_seg(Bound_pleural_vertical(1):Bound_pleural_vertical(2),Bound_pleural(1):Bound_pleural(2));    
    

    
    X=Project_intensity_Horizontal_1_BlineArea(1,:)/double(y2);%normalize
    [H,W]=size(X);
    for k=1:W
        if X(k)>1
            X(k)=1;
        end
    end
    Bmap(i,:)=X;
    
    if W>0
        
        X1=sort(X,'descend');
        if X1(1)-X1(end-uint16(0.49*W))>=0.15
    
        else
            X1(1)=10;
        end
    else
        
    end
    
    for j=1:W
        if (X(j)>0.25||X(j)>X1(1)-0.03)
            
            map(i,Bound_pleural_vertical(1)+j-1,1)=255; %find B-lines
        end
    end
    
    
    %%%for A line
    
    A3frame=sum(im_rect(i:i+10,:,:))/11;
    Aframe(:,:)=A3frame(1,:,:);
    Aarea=Aframe(:,Bound_pleural(2)+100:401);
    OriginA=NAProjection(Aarea,map(:,:,1),i)/double(y2);
    SOA=Smooth(OriginA,50);  
    SSOA=Smooth(OriginA,200);
    DIF=SOA-SSOA;
    DIF=DIF/(max(SOA));
    for m=1:(301-Bound_pleural(2))
        if DIF(m)>=0.035
            map(i,:,3)=255;
            map4(Bound_pleural(2)+100+m-1,i)=255;
        end
    end
       
    map(i,Bound_pleural_vertical(1),2)=255;
    map(i,Bound_pleural_vertical(2),2)=255;%identify Plueral line
    map2(i,Bound_pleural(1))=255;
    map2(i,Bound_pleural(2))=255;
    map3(i)=index_for_real_cut_V;

end

            
   
    mapA=zeros(Num_Frame,87,3);
    
    
    for i=3:Num_Frame-2
        if (sum(map(i-2:i+2,1,3))>=255)
            mapA(i,:,3)=255;
        end
    end
    map(:,:,3)=mapA(:,:,3);%dilation
        
    for i=3:Num_Frame-2
        if (sum(map(i-2:i+2,1,3))~=255*5)
            mapA(i,:,3)=0;
        end
    end
    map(:,:,3)=mapA(:,:,3);%erosion
    for i=3:Num_Frame-2
        if (sum(map(i-2:i+2,1,3))~=255*5)
            mapA(i,:,3)=0;
        end
    end
    map(:,:,3)=mapA(:,:,3);%erosion
        
    for i=3:Num_Frame-2
        if (sum(map(i-2:i+2,1,3))>=255)
            mapA(i,:,3)=255;
        end
    end
    map(:,:,3)=mapA(:,:,3);%dilation
    
    
    
    
    for i=2:Num_Frame-1
        for j=2:86
            if sum(sum(map(i-1:i+1,j-1:j+1,1)))>=255
                mapA(i,j,1)=255;
            end
        end
    end
    map(:,:,1)=mapA(:,:,1);%dilation
    
       for i=2:Num_Frame-1
        for j=2:86
            if sum(sum(map(i-1:i+1,j-1:j+1,1)))~=255*9
                mapA(i,j,1)=0;
            end
        end
    end
    map(:,:,1)=mapA(:,:,1);%erosion
    
       for i=2:Num_Frame-1
        for j=2:86
            if sum(sum(map(i-1:i+1,j-1:j+1,1)))~=9*255
                mapA(i,j,1)=0;
            end
        end
    end
    map(:,:,1)=mapA(:,:,1);%erosion
    
       for i=2:Num_Frame-1
        for j=2:86
            if sum(sum(map(i-1:i+1,j-1:j+1,1)))>=255
                mapA(i,j,1)=255;
            end
        end
    end
    map(:,:,1)=mapA(:,:,1);%dilation
    
            
    
    D=(Bound_pleural_vertical(2)-Bound_pleural_vertical(1)+1);%/1.2;
    N=zeros(Num_Frame-4,1);
    for i=3:Num_Frame-2

        for j=Bound_pleural_vertical(1):Bound_pleural_vertical(2)
            if (map(i,j,1)==255)&&(map(i,j,3)~=255)
               
                N(i-2,1)=N(i-2,1)+1;
            end
        end
    end
   N=sort(N,'descend'); 
   NN=N(floor(0.1*(Num_Frame-4)));
            
    
    
    


    rate(filenum,n)=NN/D;% B-lines occupancy

 






    subplot(1,2,1)
    imshow(map)
    subplot(1,2,2)
    imshow(map4)
    filename2=[num2str(filenum),'-',num2str(n),'map.jpg'];
    saveas(gcf,filename2)
    clf;
    for i=1:Num_Frame
        if map(i,1,3)~=255;
            map4(:,i)=0;
        end
    end
 Video=ABPline(map,map4,Num_Frame,im);  
for i=1:Num_Frame
    xxxx(:,:,:)=Video(i,:,:,:);
    imshow(xxxx);
    P(i)=getframe;
    clf;
end
filename2=[num2str(filenum),'-',num2str(n),'.avi'];
movie2avi(P, filename2,'FPS',45);
    
    
    
end
end
