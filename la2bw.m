function [outputImage] = la2bw(label,se2,N)
A=zeros(size(label,1),size(label,2));
outputImage = A;
idx = label2idx(label);


for labelVal = 1:N
    Idx = idx{labelVal};
    if se2(labelVal)==1
        outputImage(Idx) = 255;  
    end
        


end

% % figure;
% % imshow(outputImage);