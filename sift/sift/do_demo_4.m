%   ��л����ʹ�ô˴��룬�˴�����������������~(@^_^@)~
%   û����Ļ���������һ������Ϣ����¼�Ա����̡������������ҡ�����������(????)1��Ǯ��Ʒ����(�䨌`��)Ŷ~
%   �ǵģ��������û�п�������ͷƤ���������1��Ǯ�Ϳ��Խ����(��??????)��
%   С����ͰѴ����Ÿ������ǵ�Ҫ�ղغ�Ŷ(�ţ�3��)�Ũq?��
%   �����ţ�https://item.taobao.com/item.htm?spm=a1z10.1-c.w4004-15151018122.5.uwGoq5&id=538759553146
%   ���������ʧЧ�����׿�����������Ҫ���ͷ�MM��������ɧ��Ŷ~(*/�بv*)
%web https://item.taobao.com/item.htm?spm=a1z10.1-c.w4004-15151018122.5.uwGoq5&id=538759553146 -browser 

% This m-file demoes the usage of SIFT functions. This demo shows how
% effective SIFT can be when the images have illumination differences
% It basically takes 2
% images as input and perform image matching based on SIFT. 
% 
% Author: Yantao Zheng. Nov 2006.  For Project of CS5240
% 


% Add subfolder path.
main; 
img1_dir = 'demo-data\';
img2_dir = 'demo-data\';

img1_file = 'beaver11.bmp';
img2_file = 'beaver13.bmp';




I1=imreadbw([img1_dir img1_file]) ; 
I2=imreadbw([img2_dir img2_file]) ;


I1=imresize(I1, [240 320]);
I2=imresize(I2, [240 320]);


I1=I1-min(I1(:)) ;
I1=I1/max(I1(:)) ;
I2=I2-min(I2(:)) ;
I2=I2/max(I2(:)) ;

%fprintf('CS5240 -- SIFT: Match image: Computing frames and descriptors.\n') ;
[frames1,descr1,gss1,dogss1] = do_sift( I1, 'Verbosity', 1, 'NumOctaves', 4, 'Threshold',  0.1/3/2 ) ; %0.04/3/2
[frames2,descr2,gss2,dogss2] = do_sift( I2, 'Verbosity', 1, 'NumOctaves', 4, 'Threshold',  0.1/3/2 ) ;


fprintf('Computing matches.\n') ;
descr1 = descr1';
descr2 = descr2';

tic ; 

matches=do_match(I1, descr1, frames1',I2, descr2, frames2' ) ;
fprintf('Matched in %.3f s\n', toc) ;


