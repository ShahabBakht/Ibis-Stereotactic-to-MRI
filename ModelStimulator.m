% open the stimulator image

FigurePath = 'C:\Users\labuser\Google Drive\newResearch\Projects\Ibis Stereotactic Frame to MRI';
FigureName = 'Stimulator_long.png';

StimulatorImage = imread([FigurePath,'\',FigureName]);
StimulatorImage = rgb2gray(StimulatorImage);

% set the mm scale on the image
figure;imagesc(StimulatorImage);
[x,y] = ginput(2);
if abs(x(1) - x(2)) > abs(y(1) - y(2))
    mm_scale = abs(x(1) - x(2));
else
    mm_scale = abs(y(1) - y(2));
end

% 


