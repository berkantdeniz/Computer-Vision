function img = lab4houghlines(img)
imgRGB = img;
[row, col, ch] = size(img);
if(ch==3)
    img = rgb2gray(img);
end

imgGrey = img;
img = edge(img, 'Canny');

imgEdges = img;

[H,T,R] = hough(img,'RhoResolution',0.5,'Theta',-90:0.5:89);
%[H,T,R] = hough(img);
 P  = houghpeaks(H,20);

 

 
 
 
 
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



lines = houghlines(img,T,R,P,'FillGap',10,'MinLength',40);
figure, imshow(imgGrey), hold on
max_len = 0;
min_len = 100;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
   if(len < min_len)
       min_len = len;
      xy_short = xy;
   end 
end
 plot(xy_long(:,1),xy_long(:,2),'LineWidth',5,'Color','cyan');
 plot(xy_short(:,1),xy_short(:,2),'LineWidth',5,'Color','red');

end

