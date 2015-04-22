function [x,y, area, bb, filt] = centerd(im)

%init vars to invalid
x = 0;
y = 0;
area = 0;
bb = [0 0 0 0];

hsv = rgb2hsv(im);
filt = hsv(:,:,1) > 0.00;
filt = filt & hsv(:,:,1) < 0.20;
filt = filt & hsv(:,:,1) > 0.05;
filt = filt & hsv(:,:,2) > 0.40;
filt = filt & hsv(:,:,3) > 0.20;

%{
window = fspecial('disk', 10);
filt = conv2(filt, window, 'same');
filt = filt > 0.9;
filt = filt .* 10;
imshow(filt,[]);
uiwait
%}
%maxima =  supress(filt);
%filt = filt .* (maxima > 0.5);
%filt = filt .* maxima;
%imshow(filt, []);
%uiwait


props = regionprops(filt);
maxa = max([props(:).Area]);
if(length(props) > 0 && maxa > 1000)
    C = props([[props(:).Area] == maxa]);
    y = C.Centroid(2);
    x = C.Centroid(1);
    area = C.Area;
    bb = round(C.BoundingBox);

    %return

    sel = filt(bb(2):(bb(2)+bb(4)),bb(1):(bb(1)+bb(3)));
    %imshow(hsv(:,:,2),[])
    gau = fspecial('disk', 13);
    %gau = fspecial('gaussian', [40,40],1);
    sel = conv2(sel, gau, 'same');

    maxp = max(max(sel));  
    mask = sel > 0.98*maxp;
    sel(~mask) = 0;
    [y,x] = find(sel);
    y = y .+ bb(2);
    x = x .+ bb(1);
    %imshow(sel,[])
    %uiwait
end

%{
while true
end
%}

%uiwait
