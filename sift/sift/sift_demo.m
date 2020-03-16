%   ��л����ʹ�ô˴��룬�˴�����������������~(@^_^@)~
%   û����Ļ���������һ������Ϣ����¼�Ա����̡������������ҡ�����������(????)1��Ǯ��Ʒ����(�䨌`��)Ŷ~
%   �ǵģ��������û�п�������ͷƤ���������1��Ǯ�Ϳ��Խ����(��??????)��
%   С����ͰѴ����Ÿ������ǵ�Ҫ�ղغ�Ŷ(�ţ�3��)�Ũq?��
%   �����ţ�https://item.taobao.com/item.htm?spm=a1z10.1-c.w4004-15151018122.5.uwGoq5&id=538759553146
%   ���������ʧЧ�����׿�����������Ҫ���ͷ�MM��������ɧ��Ŷ~(*/�بv*)
%web https://item.taobao.com/item.htm?spm=a1z10.1-c.w4004-15151018122.5.uwGoq5&id=538759553146 -browser 

% I1=imreadbw('D:\VisualSemantic\corrSIFT\data\object0007.view04_rot.png') ; 
% I2=imreadbw('D:\VisualSemantic\corrSIFT\data\object0007.view04.png') ;
% I1=imreadbw('\data\landscape-a.jpg') ; 
% I2=imreadbw('\data\landscape-b.jpg') ;
I1=imreadbw('\demo-data\image068.jpg') ; 
I2=imreadbw('\demo-data\image069.jpg') ;

I1=imresize(I1, [240 320]);
I2=imresize(I2, [240 320]);


I1=I1-min(I1(:)) ;
I1=I1/max(I1(:)) ;
I2=I2-min(I2(:)) ;
I2=I2/max(I2(:)) ;

fprintf('Computing frames and descriptors.\n') ;
[frames1,descr1,gss1,dogss1] = do_sift( I1, 'Verbosity', 1, 'NumOctaves', 4, 'Threshold',  0.2/3/2 ) ; %0.04/3/2
[frames2,descr2,gss2,dogss2] = do_sift( I2, 'Verbosity', 1, 'NumOctaves', 4, 'Threshold',  0.2/3/2 ) ;

% figure(11) ; clf ; plotss(dogss1) ; colormap gray ;
% figure(12) ; clf ; plotss(dogss2) ; colormap gray ;
% drawnow ;
% 
% figure(2) ; clf ;
% subplot(1,2,1) ; imagesc(I1) ; colormap gray ;
% hold on ;
% h=plotsiftframe( frames1 ) ; set(h,'LineWidth',2,'Color','g') ;
% h=plotsiftframe( frames1 ) ; set(h,'LineWidth',1,'Color','k') ;
% 
% subplot(1,2,2) ; imagesc(I2) ; colormap gray ;
% hold on ;
% h=plotsiftframe( frames2 ) ; set(h,'LineWidth',2,'Color','g') ;
% h=plotsiftframe( frames2 ) ; set(h,'LineWidth',1,'Color','k') ;

fprintf('Computing matches.\n') ;
% By passing to integers we greatly enhance the matching speed (we use
% the scale factor 512 as Lowe's, but it could be greater without
% overflow)
%descr1=uint8(512*descr1) ;
%descr2=uint8(512*descr2) ;
descr1 = descr1';
descr2 = descr2';
tic ; 
matches=do_match( descr1, descr2 ) ;
fprintf('Matched in %.3f s\n', toc) ;

figure(3) ; clf ;
plotmatches(I1,I2,frames1(1:2,:),frames2(1:2,:),matches) ;
drawnow ;
