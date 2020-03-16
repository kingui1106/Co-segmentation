function [vx, vy, error] = MaskedSiftFlow(im1, im2, mask1, mask2, param)


if ~exist('param','var')
    param.alpha=2;
    param.d=40;
    param.gamma=0.005;
    param.nlevels=3;
    param.wsize=2;
    param.topwsize=10;
    param.nTopIterations = 60;
    param.nIterations= 30;
end

if ~exist('mask1','var')
    [vx, vy, energy] = SIFTflowc2f(im1, im2, param, 0);
else
    [vx, vy, energy] = MaskedSIFTflowc2f(im1, im2, mask1, mask2, param, 0);
end
im2Warp = mexWarpImageInt(im1, im2, int32(vx),int32(vy));
error = sum(abs(im2Warp-double(im1)), 3); % L1