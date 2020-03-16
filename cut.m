file_path = 'D:\毕业设计\jieguo\yuantu\';% 图像文件夹路径 ?
file_path2 = 'D:\毕业设计\jieguo\fenge\';% 图像文件夹路径 ?
img_path_list = dir('D:\毕业设计\jieguo\yuantu\*.jpg');%获取该文件夹中所有bmp格式的图像
img_path_list2 = dir('D:\毕业设计\jieguo\fenge\*.png');

img_num = length(img_path_list);%获取图像总数量?
I=cell(1,img_num);
figure;
if img_num > 0 %有满足条件的图像 ?
    for j = 1:img_num %逐一读取图像 ?
        image_name = img_path_list(j).name;% 图像名 ?
        RGB = imread(strcat(file_path,image_name)); 
        image_name2 = img_path_list2(j).name;% 图像名 ?
        BW = imread(strcat(file_path2,image_name2));   
        %maskedImage = RGB;
        %BW(BW(:)==255)=RGB;
       % maskedImage(repmat(~BW,[1 1 3])) = 0;
        BW=rgb2gray(BW);
        maskedImage = RGB;
        maskedImage(repmat(~BW,[1 1 3])) = 0;
   
        subplot(2,3,j),imshow(BW);
        subplot(2,3,j+3),imshow(maskedImage);
        

        
        
        %这里直接可以访问细胞元数据的方式访问数据
        
    end
end
