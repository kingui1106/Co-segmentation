function [segments,img_slic] = vl_slic_test(im, region, rate)
% VL_SLIC_TEST show result of vl_slic
%   vl_slic only return the segments which is puzzled, 
%   this function use vl_grad to compute the edge of the segments, and
%   show the final image.
    if nargin < 2
       region = 10;
       rate = 1;
    end
    if nargin < 3
       rate = 1; 
    end
    im_single = im2single(im);
    segments = vl_slic(im_single, region, rate, 'verbose');

    %figure(1); clf;
    % overaly segmentation
    [sx, sy] = vl_grad(double(segments), 'type', 'forward');
    s = find(sx | sy);
    imp = im;

    num_of_pixel = numel(im(:,:,1));
    % (r g b) = 0, black line
    imp([s s+num_of_pixel s+2*num_of_pixel]) = 254;
    img_slic=imp;
    %image(imp);
   % title('SLIC ³¬ÏñËØ');