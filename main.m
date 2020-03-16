clear;
close all;
db='./data/';
vlf;
%slic超像素
img = imread('D:\毕业设计\GMS_cosegmentation_protected\data\0006.jpg');
%img = imread('xuejie.jpg');

%slic 超像素
regionSize = 30 ;
regularizer = 1 ;
segments = vl_slic_test(img, regionSize, regularizer) ;
x=segments+1;
outImage=sp2g(img,x,max(max(x)));%计算超像素
figure;
imshow(outImage);
out=rgb2gray(outImage);
N=max(max(x));
a=[];
idx = label2idx(x);
for labelVal = 1:N
    Idx = idx{labelVal};
    b=mean(out(Idx));
    a=[a;b];

end




% % % I=img;
% % % rgb(I);


% % % % % % % % % % % % % % % % % %color,hsv
%%
%hsv颜色直方图
color=colorhist(img);
figure;
stem(color);
title('hsv 颜色直方图');
%%
% % % i=img;
% % % gl=GLCM(i);
% % % figure;
% % % imshow(gl);
%%

%texture,局部二值模式LBP
I1=rgb2gray(img);
%I1=img;
SP=[-1 -1; -1 0; -1 1; 0 -1; -0 1; 1 -1; 1 0; 1 1];
I2=lbp(I1,SP,0,'i');                 %LBP图像
%mapping=getmapping(8,'u2'); 
%I2=lbp(I1,1,8,mapping,'h'); 
%       H1=LBP(I,1,8,mapping,'h');
figure,subplot(1,2,1),imshow(img),title('原图');
subplot(1,2,2), imshow(I2),title('lbp 纹理特征1');



%%
%siftflow

%%%%%demo_sift();
im1=imread('./SiftFlow/Mars-1.jpg');
im2=imread('./SiftFlow/Mars-2.jpg');

im1=imresize(imfilter(im1,fspecial('gaussian',7,1.),'same','replicate'),0.5,'bicubic');
im2=imresize(imfilter(im2,fspecial('gaussian',7,1.),'same','replicate'),0.5,'bicubic');

im1=im2double(im1);
im2=im2double(im2);

%figure;imshow(im1);figure;imshow(im2);

cellsize=3;
gridspacing=1;

addpath(fullfile(pwd,'SiftFlow'));
addpath(fullfile(pwd,'SiftFlow/mexDenseSIFT'));
addpath(fullfile(pwd,'SiftFlow/mexDiscreteFlow'));

sift1 = mexDenseSIFT(im1,cellsize,gridspacing);
sift2 = mexDenseSIFT(im2,cellsize,gridspacing);

SIFTflowpara.alpha=2*255;
SIFTflowpara.d=40*255;
SIFTflowpara.gamma=0.005*255;
SIFTflowpara.nlevels=4;
SIFTflowpara.wsize=2;
SIFTflowpara.topwsize=10;
SIFTflowpara.nTopIterations = 60;
SIFTflowpara.nIterations= 30;


tic;[vx,vy,energylist]=SIFTflowc2f(sift1,sift2,SIFTflowpara);toc

warpI2=warpImage(im2,vx,vy);
figure;imshow(im1);
figure;imshow(warpI2);

% display flow
clear flow;
flow(:,:,1)=vx;
flow(:,:,2)=vy;
figure;imshow(flowToColor(flow));

%return;

% this is the code doing the brute force matching
% % tic;
% % [flow2,energylist2]=mexDiscreteFlow(sift1,sift2,[alpha,alpha*20,60,30]);toc
% % figure;imshow(flowToColor(flow2));
%%

% % addpath(fullfile(pwd,'SLIC_mex'));
% % %img = imread('./SLIC_mex/bee.jpg');
% % [labels, numlabels] = slicmex(img,500,20);%numlabels is the same as number of superpixels
% % figure;
% % imagesc(labels);
% % 
% % a=labels;
% % labels=double(labels);
% % figure;
% % imagesc(labels);
labels=double(segments);

img2=rgb2gray(img);
img2=double(img2);

L1=Laplacian_GK(img2,1);

T=0;
para.ul=1;
para.uu=0;
para.mu=1;
para.lamda=1;
x=double(segments);
[W, b, F]=FME_semi(x,L1,T,para);








        
 