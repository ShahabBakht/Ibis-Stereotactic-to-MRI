%% Load Stimulator Images

% open the stimulator image

FigurePath = '.\';
FigureNameShort = 'Stimulator_short.png';
FigureNameLong = 'Stimulator_long.png';

StimulatorImageShort = imread([FigurePath,'\',FigureNameShort]);
StimulatorImageShort = rgb2gray(StimulatorImageShort);
StimulatorImageLong = imread([FigurePath,'\',FigureNameLong]);
StimulatorImageLong = rgb2gray(StimulatorImageLong);


%% Resize Images to match

% set the mm scale on the image
figure('units','normalized','outerposition',[0 0 1 1])
imagesc(double(StimulatorImageShort));colormap(jet);axis image
display('how much is 1 mm on this image? - select two points in 1 mm distance');
[x_mm_scale_s,y_mm_scale_s] = ginput(2);
if abs(x_mm_scale_s(1) - x_mm_scale_s(2)) > abs(y_mm_scale_s(1) - y_mm_scale_s(2))
    mm_scale_s = abs(x_mm_scale_s(1) - x_mm_scale_s(2));
else
    mm_scale_s = abs(y_mm_scale_s(1) - y_mm_scale_s(2));
end

figure('units','normalized','outerposition',[0 0 1 1])
imagesc(double(StimulatorImageLong));colormap(jet);axis image
display('how much is 1 mm on this image? - select two points in 1 mm distance');
[x_mm_scale_l,y_mm_scale_l] = ginput(2);
if abs(x_mm_scale_l(1) - x_mm_scale_l(2)) > abs(y_mm_scale_l(1) - y_mm_scale_l(2))
    mm_scale_l = abs(x_mm_scale_l(1) - x_mm_scale_l(2));
else
    mm_scale_l = abs(y_mm_scale_l(1) - y_mm_scale_l(2));
end

StimulatorImageShort_resize = imresize(StimulatorImageShort,mm_scale_l/mm_scale_s);
close all
clc;

StimulatorImageShort_resize = flipud(padarray(flipud(StimulatorImageShort_resize),[size(StimulatorImageLong,1)-size(StimulatorImageShort_resize,1) size(StimulatorImageLong,2)-size(StimulatorImageShort_resize,2)],0,'pre'));

%% Sample the Stimulator Shape

% select the points along the stimulator center 
figure('units','normalized','outerposition',[0 0 1 1])
h = imagesc(double(StimulatorImageShort_resize));colormap(jet);axis image
display('select as many points as you can along the stimulator');
[x_c_s,y_c_s] = ginput;
hold on; scatter(x_c_s,y_c_s,'r')
colormap(gray)

figure('units','normalized','outerposition',[0 0 1 1])
imagesc(double(StimulatorImageLong));colormap(jet);axis image
display('select as many points as you can along the stimulator');
[x_c_l,y_c_l] = ginput;
hold on; scatter(x_c_l,y_c_l,'r')
colormap(gray)

%% Curve Fitting

f_c_s = fit(x_c_l,y_c_l,'poly2');

hold on;plot(f_c_s,x_c_l(1:end),y_c_l(1:end));

%% stimulator length calculation
xtest = min(x_c_l):0.1:max(x_c_l);
d = 0;
for i = 1:length(xtest)
    
    ytest(i) = feval(f_c_s,xtest(i));
    if i > 1
        d = d + sqrt((ytest(i) - ytest(i-1))^2+(xtest(i) - xtest(i-1))^2);
    end
    
end

StimulatorLength = d./mm_scale_l;


