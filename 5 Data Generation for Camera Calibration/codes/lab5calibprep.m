
tic
img = imread('calibrationObject.png');
imgRGB = img;
[row, col, ch] = size(img);
if(ch==3)
    img = rgb2gray(img);
end

imgGrey = img;
img = edge(img, 'Canny', [0.10 0.12]);

imgEdges = img;

[H,T,R] = hough(img,'RhoResolution',0.5,'Theta',-90:0.5:89);
%[H,T,R] = hough(img);
 P  = houghpeaks(H,30, 'Threshold', 0.05 );

 

 
 
 
 
subplot(2,2,1);
imshow(imgRGB);
title('checkers.png RGB');
subplot(2,2,2);
imshow(imgEdges);
title('checkers.png Canny');
subplot(2,2,3);
imshow(imadjust(rescale(H)),'XData',T,'YData',R,...
      'InitialMagnification','fit');
title('Hough transform of checkers.png');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(gca,gray);
subplot(2,2,4);
imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
title('Hough peaks of checkers.png');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
plot(T(P(:,2)),R(P(:,1)),'s','color','white');


pause(1);
lines = houghlines(img,T,R,P,'FillGap',40,'MinLength',40);
figure, imshow(imgGrey), hold on

theta1 = lines(11).theta;
rho1 = lines(11).rho;
theta2 = lines(2).theta;
rho2 = lines(2).rho;

A = [ cosd(theta1) sind(theta1); cosd(theta2) sind(theta2)];
RhoVector = [rho1 ; rho2];

x1 = 0:0.1:350;
x2 = 0:0.1:350;
y1 = (rho1-x1*cosd(theta1))/sind(theta1);
y2 = (rho2-x2*cosd(theta2))/sind(theta2);

pts = inv(A)*RhoVector;
hold on;
plot(pts(1),pts(2),'w*');
 plot(x1,y1,'LineWidth',0.2,'Color','m');
 plot(x2,y2,'LineWidth',0.2,'Color','m');

 C  =  corner(imgGrey);
 hold on;
 plot(C(:,1),C(:,2),'bo');
 
 
 % pts1 and pts2 returns intersection
 % harris returns 221,199 and 219,205
 distance1 = sqrt((pts(1)-221)^2 + (pts(2)-199)^2 );
 distance2 = sqrt((pts(1)-219)^2 + (pts(2)-205)^2 );

 
 

for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   rho = lines(k).rho;
   theta = lines(k).theta;
   
   
   
%   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
%    % Plot beginnings and ends of lines
%    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
%    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
end



toc



