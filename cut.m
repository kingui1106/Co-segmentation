file_path = 'D:\��ҵ���\jieguo\yuantu\';% ͼ���ļ���·�� ?
file_path2 = 'D:\��ҵ���\jieguo\fenge\';% ͼ���ļ���·�� ?
img_path_list = dir('D:\��ҵ���\jieguo\yuantu\*.jpg');%��ȡ���ļ���������bmp��ʽ��ͼ��
img_path_list2 = dir('D:\��ҵ���\jieguo\fenge\*.png');

img_num = length(img_path_list);%��ȡͼ��������?
I=cell(1,img_num);
figure;
if img_num > 0 %������������ͼ�� ?
    for j = 1:img_num %��һ��ȡͼ�� ?
        image_name = img_path_list(j).name;% ͼ���� ?
        RGB = imread(strcat(file_path,image_name)); 
        image_name2 = img_path_list2(j).name;% ͼ���� ?
        BW = imread(strcat(file_path2,image_name2));   
        %maskedImage = RGB;
        %BW(BW(:)==255)=RGB;
       % maskedImage(repmat(~BW,[1 1 3])) = 0;
        BW=rgb2gray(BW);
        maskedImage = RGB;
        maskedImage(repmat(~BW,[1 1 3])) = 0;
   
        subplot(2,3,j),imshow(BW);
        subplot(2,3,j+3),imshow(maskedImage);
        

        
        
        %����ֱ�ӿ��Է���ϸ��Ԫ���ݵķ�ʽ��������
        
    end
end
