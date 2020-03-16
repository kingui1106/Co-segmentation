
img = imread('./image/star.png');
[idxImg, spNum] = SLIC_mex(img, 10, 10);
imshow(idxImg);