%   ��л����ʹ�ô˴��룬�˴�����������������~(@^_^@)~
%   û����Ļ���������һ������Ϣ����¼�Ա����̡������������ҡ�����������(????)1��Ǯ��Ʒ����(�䨌`��)Ŷ~
%   �ǵģ��������û�п�������ͷƤ���������1��Ǯ�Ϳ��Խ����(��??????)��
%   С����ͰѴ����Ÿ������ǵ�Ҫ�ղغ�Ŷ(�ţ�3��)�Ũq?��
%   �����ţ�https://item.taobao.com/item.htm?spm=a1z10.1-c.w4004-15151018122.5.uwGoq5&id=538759553146
%   ���������ʧЧ�����׿�����������Ҫ���ͷ�MM��������ɧ��Ŷ~(*/�بv*)
web https://item.taobao.com/item.htm?spm=a1z10.1-c.w4004-15151018122.5.uwGoq5&id=538759553146 -browser 

% This m-file demoes the usage of SIFT functions. It generates SIFT keypionts and descriptors for one input image. 
% Author: Yantao Zheng. Nov 2006.  For Project of CS5240


% Add subfolder path.
main; 
clc;
clear;

img1_dir = 'demo-data\';

img1_file = 'beaver11.bmp';

I1=imreadbw([img1_dir img1_file]) ; 
I1_rgb = imread([img1_dir img1_file]) ; 
I1=imresize(I1, [240 320]);

I1_rgb =imresize(I1_rgb, [240 320]);
I1=I1-min(I1(:)) ; %ͼ���ֵ���ſ��ܲ���ֵ����0-1�ķ�Χ������
I1=I1/max(I1(:)) ; %���������¹�һ��ͼ�����ź������

%fprintf('CS5240 -- SIFT: Match image: Computing frames and descriptors.\n') ;
[frames1,descr1,gss1,dogss1 ] = do_sift( I1, 'Verbosity', 1, 'NumOctaves', 4, 'Threshold',  0.1/3/2 ) ; %0.04/3/2



figure(1) ; clf ; plotss(dogss1) ; colormap gray ;
drawnow ;

figure(2) ; clf ;
imshow(I1_rgb) ; axis image ;

hold on ;
h=plotsiftframe( frames1 ) ; set(h,'LineWidth',1,'Color','g') ;
