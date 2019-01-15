function [] = lab4houghcircles()
img = imread('circlesBrightDark.png');
[row, col, ch] = size(img);
if(ch==3)
    img = rgb2gray(img);
end

Rmin = 20;
Rmax = 40;
figure;
subplot(1,3,1);
imshow(img);
title('Detected Circles using Hough Transform 20<= R <= 40');
[centersBright, radiiBright] = imfindcircles(img,[Rmin Rmax],'ObjectPolarity','bright');
[centersDark, radiiDark] = imfindcircles(img,[Rmin Rmax],'ObjectPolarity','dark');
viscircles(centersBright, radiiBright,'Color','b');
viscircles(centersDark, radiiDark,'LineStyle','--');
subplot(1,3,2);
imshow(img);
title('Detected Black Circles using Hough Transform 20<= R <= 60, sensitivty 0.7 ');
Rmin = 20;
Rmax = 60;
[centersDark, radiiDark] = imfindcircles(img,[Rmin Rmax],'ObjectPolarity','dark', 'Sensitivity', 0.7);
viscircles(centersDark, radiiDark,'Color','g');
subplot(1,3,3);
imshow(img);
title('Detected White Circles using Hough Transform 20<= R <= 60 ');
[centersBright, radiiBright] = imfindcircles(img,[Rmin Rmax],'ObjectPolarity','bright');
viscircles(centersBright, radiiBright,'Color','y');


end
