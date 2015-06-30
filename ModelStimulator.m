%% Load Stimulator Images

% open the stimulator image

FigurePath = '.\';
FigureName = 'Stimulator_long.png';

StimulatorImage = imread([FigurePath,'\',FigureName]);
StimulatorImage = rgb2gray(StimulatorImage);

%% Sample the Stimulator Shape

% set the mm scale on the image
figure('units','normalized','outerposition',[0 0 1 1])
imagesc(double(StimulatorImage));colormap(jet);axis image
display('how much is 1 mm on this image? - select two points in 1 mm distance');
[x_mm_scale,y_mm_scale] = ginput(2);
if abs(x_mm_scale(1) - x_mm_scale(2)) > abs(y_mm_scale(1) - y_mm_scale(2))
    mm_scale = abs(x_mm_scale(1) - x_mm_scale(2));
else
    mm_scale = abs(y_mm_scale(1) - y_mm_scale(2));
end

% select the points on the stimulator upper border
display('select as many points as you can on the upper border of the stimulator');
[x_u,y_u] = ginput;
hold on; scatter(x_u,y_u,'r')

% select the points on the stimulator lower border
display('select as many points as you can on the lower border of the stimulator');
[x_l,y_l] = ginput;
hold on; scatter(x_l,y_l,'r')
colormap(gray)

% distance between the cable and the tip of the stimulator
display('select two points: first at the end of the cable, second at the tip of the stimulator');
[x_c2t,y_c2t] = ginput(2);
hold on; scatter(x_c2t,y_c2t,'b')
colormap(gray)

%% Curve Fitting

f_l = fit(x_l,y_l,'power1');
f_u = fit(x_u,y_u,'power1');
hold on; plot(f_l,x_l,y_l);
hold on; plot(f_u,x_u,y_u);
figure; xaxis([min(x_l),max(x_l)]);plot(f_l)








