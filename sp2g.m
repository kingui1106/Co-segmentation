function [outputImage,Gout] = sp2g(img,label, N)
%BW = boundarymask(label); %获取对象轮廓
%figure;
%imshow(imoverlay(img,BW,'cyan'),'InitialMagnification',67); %
A=img;
%B=img_lbp;
outputImage = zeros(size(A),'like',A);
idx = label2idx(label);
numRows = size(A,1);
numCols = size(A,2);
t=zeros(3,1);
Gout=[];
for labelVal = 1:N
    redIdx = idx{labelVal};
    greenIdx = idx{labelVal}+numRows*numCols;
    blueIdx = idx{labelVal}+2*numRows*numCols;
    
% %     if labelVal==2
% %         
% %     outputImage(redIdx) = 1;
% %     outputImage(greenIdx) = 1;
% %     outputImage(blueIdx) = 1;  
% %         
        
% %     else
    outputImage(redIdx) = mean(A(redIdx));
    t(1)=mean(A(redIdx));
    outputImage(greenIdx) = mean(A(greenIdx));
    t(2)= mean(A(greenIdx));
    outputImage(blueIdx) = mean(A(blueIdx));
    t(3)=mean(A(blueIdx));
    
    %t(4)=mean(B(redIdx));
    
    Gout=[Gout t];
    
    
    
   % end

end

 %figure;
% imshow(outputImage);