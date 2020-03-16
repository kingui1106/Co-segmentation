%   感谢亲亲使用此代码，此代码解决您的问题了吗~(@^_^@)~
%   没解决的话告诉亲亲一个好消息，登录淘宝店铺“大成软件工作室”，可以下载(????)1分钱成品代码(′▽`〃)哦~
%   是的，亲亲真的没有看错，挠破头皮的问题真的1分钱就可以解决了(づ??????)づ
%   小的这就把传送门给您，记得要收藏好哦(づ￣3￣)づ╭?～
%   传送门：https://item.taobao.com/item.htm?spm=a1z10.1-c.w4004-15151018122.5.uwGoq5&id=538759553146
%   如果传送门失效，亲亲可以来店铺讨要，客服MM等亲亲来骚扰哦~(*/ω╲*)
%web https://item.taobao.com/item.htm?spm=a1z10.1-c.w4004-15151018122.5.uwGoq5&id=538759553146 -browser 

% This m-file demoes the usage of SIFT functions. This demo shows how
% effective SIFT can be when the images have small viewpoint differences
% It basically takes 2
% images as input and perform image matching based on SIFT. 
% 
% Author: Yantao Zheng. Nov 2006.  For Project of CS5240
% 


% Add subfolder path.
main; 
img1_dir = 'demo-data\';
img2_dir = 'demo-data\';

img1_file = 'image069.JPG';
img2_file = 'image068.JPG';




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


