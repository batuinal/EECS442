debug = false;
X = [];
Y = [];
I = [];

params = [];

if ~exist('dirname')
    dirname = uigetdir('data');
else
    disp(['Assuming dirname=' dirname ' clear it to reset']);
end

if ~exist('fstem')
    fstem = input('enter file name stem: ', 's');
else
    disp(['Assuming fstem=' fstem ' clear it to reset']);
end

l = glob([dirname '/' fstem '*.jpg']);
disp(['Found ' int2str(length(l)) ' files']);


figure(1)
%for i = 11:40
count = 0
for i = 1:length(l)

    fflush(stdout);
    iml = imread(l{i,1});
    [xi,yi, ai, bb, filt] = centerd(iml);

    %make sure it's big, and not cut off the edge of frame
    if(ai > 0)
        count = count + 1;

        clf
        hold on
        imshow(iml)
        rectangle('position',bb,'Edgecolor','g');
        cbb = cupdims(iml);
        %rectangle('position',cbb,'Edgecolor','b');

        plot([cbb(1),cbb(1)+cbb(3)],[cbb(2),cbb(2)], 'b*b', 'linewidth',8)

        X = [X; xi];
        Y = [Y; yi];
        I = [I; i];

        %clf
        title('Ball found!');
        %rectangle('position',bb,'Edgecolor','g')
        plot(xi,yi,'r+')

        if(count == 6)
            [a,b,c,d,e,R] = fit_para(X, Y,'4');
            x = 1:size(iml,1);
            y = a*x.^4 + b*x.^3 + c*x.^2+ d*x + e;
            plot(x,y);

        end
        plot(X,Y,'r+');

        %waitforbuttonpress
        uiwait
    elseif(debug)
        title('No Ball Found...');
        hsv = rgb2hsv(iml);
        [y,x] = ginput(1);
        x = round(x);
        y = round(y);
        h = hsv(x,y,1)
        s = hsv(x,y,2)
        v = hsv(x,y,3)
    else
        disp(['No ball found frame ' int2str(i)]);
    end
end

R = sum((Y - (a*X.^4 + b*X.^3 + c*X.^2 + d*X + e)).^2);
R = R/length(Y)

a
b
c
d
e

hold on
imshow(iml)
x = 1:size(iml,1);
y = a*x.^4 + b*x.^3 + c*x.^2+ d*x + e;
plot(x,y);


fflush(stdout);
uiwait



