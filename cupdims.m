function [bb] = cupdims(im)

hsv = rgb2hsv(im);
filt = hsv(:,:,1) > 0.00;
filt = filt & (hsv(:,:,1) < 0.05 | hsv(:,:,1) > 0.85);
filt = filt & hsv(:,:,2) > 0.45;
filt = filt & hsv(:,:,3) > 0.15;

props = regionprops(filt);
maxa = max([props(:).Area]);
if(maxa > 1)
    C = props([[props(:).Area] == maxa]);
    bb = round(C.BoundingBox);
else
    bb = [ 0 0 0 0 ]
end

