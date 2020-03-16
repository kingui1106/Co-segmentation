clear all;
close all;

addpath( genpath( '.' ) );

imageFiles = dir(fullfile('./Datasets/image/'));
imageFilesNUM = length(imageFiles)-2;

for imgFilesnum = 1:imageFilesNUM

   
    img_path = ['Datasets/image/' imageFiles(imgFilesnum+2).name '/image/'];
    out_path = ['./result/' imageFiles(imgFilesnum+2).name '/'];
    mkdir([out_path 'result/']);
    mkdir([out_path 'regions/']);


 

    imgFiles = dir(fullfile(img_path ,'*.jpg'));
    LengthimgFiles = length(imgFiles);
    X=[];
    T=[];
    img_group={};
    
    for k = 1:LengthimgFiles                    
        %%if( ~exist( fullfile( out_path, 'regions', [imgFiles(k).name(1:end-4), '.mat'] ), 'file' ) )
            img_name = strcat(img_path,imgFiles(k).name);
            img = imread(img_name);
            img=imresize(img,[234,340]);
            regionSize = 25 ;
            regularizer = 1 ;
            subplot(2,LengthimgFiles,k),imshow(img);
            [segments,img_slic] = vl_slic_test(img, regionSize, regularizer) ;
            subplot(2,LengthimgFiles,k+LengthimgFiles),imshow(img_slic);
            se=segments+1;
            [outImage,a] =sp2g(img,se,max(max(se)));%计算超像素
            X=[X a];
            num_s=max(max(se));
            t=get_T(num_s,se);
            
            
            T=[T;t];
            temp.img=img;
            temp.se=se;
            img_group{1,k}=temp;
            
% %             figure;
% %             imshow(outImage);
% %             out=rgb2gray(outImage);
% %             N=max(max(se));
% %             a=[];
% %             idx = label2idx(se);
% %             for labelVal = 1:N
% %                 Idx = idx{labelVal};
% %                 b=mean(out(Idx));
% %                 a=[a;b];
% %                 
% %             end
% %             X=[X a];

% %             filename = fullfile( out_path, 'regions', [imgFiles(k).name(1:end-4), '.mat'] );
% %             save( filename, 'se','img' );
% %             out=rgb2gray(outImage);
% %             out=reshape(out,[],1);
% %          
% %             x=[x out];
        %%end
    end
    
end

%% 一列一个数据

%L1=Laplacian_LRGA(X,2,1);
para.k = 5;
[L1,S]=Laplacian_GK(X,para);
% S = full(S);
% idxBgSuper = find(T(:,1) == 1);
% 
% for i = 1 : size(idxBgSuper,1)
%     for j = 1:size(idxBgSuper,1)
%         S(idxBgSuper(i),idxBgSuper(j)) = 1; 
%     end
% end
% S = (S+S')/2;

% % D = diag(sum(S,2));
% % L1 = D - S;

%%c=
%%


%%
%T2=zeros(280,1);
%T2=~T;
T2=zeros(size(T));
%T2=get_T2(T,LengthimgFiles);

T=[T,T2];
%%%%%%%%%%%%%%%%一阶段背景预测前景
%%


para.ul=25; 
para.uu=1;
para.mu=10^2;
para.lamda=10;
%% HotBalloons
% para.ul=25; 
% para.uu=1;
% para.mu=10^2;
% para.lamda=10;
%% bear
% para.ul=20; 
% para.uu=1;
% para.mu=10^7;
% para.lamda=10^2;
%% car
% para.ul=20; 
% para.uu=1;
% para.mu=10^3;
% para.lamda=10^1;
%% people
% para.ul=32; 
% para.uu=1;
% para.mu=10^6;
% para.lamda=10^3;
%%  helicopter
% para.ul=40; 
% para.uu=1;
% para.mu=10^6;
% para.lamda=10^4;

%%


%T(find(T(:,1)==0),2)=0.5;
T = zeros(size(T2,1),1);
T(1:10) = 1;
%T(88,2)=1;
[W,b,F]=FME_semi(X,L1,T,para);
%%

for jj=1:LengthimgFiles
    se2=zeros(size(t));
    s=1+(jj-1)*num_s;
    e=num_s+(jj-1)*num_s;
    ii=1;
    for kk=s:e
        
        if F(kk)<0.4
            se2(ii)=1;
        
        else
                se2(ii)=0;
                       
        end
%         if F(kk,2)>0.85
%             se2(ii)=1;
%         else
%             se2(ii)=0;
%         end
            
            
        ii=ii+1;
        
    end
    %se2=reshape(se2,24,34);
    img_group{1,jj}.f=se2;
end

%% 根据双列F，还原结果
% se2=zeros(size(T,1),1);
% 
% for jj=1:LengthimgFiles
%     se2=zeros(size(t));
%     s=1+(jj-1)*num_s;
%     e=num_s+(jj-1)*num_s;
%     ii=1;
%     for kk=s:e
%         
%         if F(kk,1)>F(kk,2)
%             se2(ii)=0;
%         
%         else
%                 se2(ii)=1;
%                        
%         end
% %         if F(kk,2)>0.85
% %             se2(ii)=1;
% %         else
% %             se2(ii)=0;
% %         end
%             
%             
%         ii=ii+1;
%         
%     end
%     %se2=reshape(se2,24,34);
%     img_group{1,jj}.f=se2;
% end
%%
figure;
for jj=1:LengthimgFiles
    se=img_group{1,jj}.se;
    se2=img_group{1,jj}.f;
    BW=la2bw(se,se2,num_s);

    RGB=img_group{1,jj}.img;
    maskedImage = RGB;
    maskedImage(repmat(~BW,[1 1 3])) = 0;
    subplot(2,LengthimgFiles,jj),imshow(BW);
    subplot(2,LengthimgFiles,jj+LengthimgFiles),imshow(maskedImage);
    img_group{1,jj}.result=maskedImage;
end


%% 


% para.ul=40; 
% para.uu=1;
% para.mu=10^6;
% para.lamda=10;
%[W,b,F2]=FME_semi(X,L1,T,para);
%%  二阶段 
TT=[];
X=[];
T=[];
%%

jj=0;
for jj=1:LengthimgFiles
     img_name = strcat(img_path,imgFiles(k).name);
            img = img_group{1,jj}.result;
            img=imresize(img,[234,340]);
           
            se=img_group{1,jj}.se;
            [outImage,a] =sp2g(img,se,max(max(se)));%计算超像素
            X=[X a];
            num_s=max(max(se));
            t=get_T(num_s,se);
            
            
            T=[T;t];
            temp.img=img;
            temp.se=se;
            %img_group{1,k}=temp;
            

    end


%%
para.k = 5;
[L2,S]=Laplacian_GK(X,para);
%%  分割


 
 for k = 1:LengthimgFiles
     TT=[TT;img_group{1,k}.f];
 end
 
para.ul=2; 
para.uu=1;
para.mu=10^1;
para.lamda=10^2;

[W,b,F2]=FME_semi(X,L1,T,para);


%% 
jj=0;
for jj=1:LengthimgFiles
    se2=zeros(size(t));
    s=1+(jj-1)*num_s;
    e=num_s+(jj-1)*num_s;
    ii=1;
    for kk=s:e
        
        if F2(kk)<0.5
            se2(ii)=1;
        
        else
                se2(ii)=0;
                       
        end
%         if F(kk,2)>0.85
%             se2(ii)=1;
%         else
%             se2(ii)=0;
%         end
            
            
        ii=ii+1;
        
    end
    %se2=reshape(se2,24,34);
    img_group{1,jj}.f=se2;
end
%%
figure;
jj=0;
for jj=1:LengthimgFiles
    se=img_group{1,jj}.se;
    se2=img_group{1,jj}.f;
    BW=la2bw(se,se2,num_s);

    RGB=img_group{1,jj}.img;
    maskedImage = RGB;
    maskedImage(repmat(~BW,[1 1 3])) = 0;
    subplot(2,LengthimgFiles,jj),imshow(BW);
    subplot(2,LengthimgFiles,jj+LengthimgFiles),imshow(maskedImage);
end
