function [img2,img3] = lab2sobelfilt(img)

[row, col, ch] = size(img);
if(ch==3)
    img = rgb2gray(img);
end

img = double(img);
K=1;
x = [ -1 0 1 ; -2 0 2; -1 0 1 ];
y = [ 1 2 1 ; 0 0 0; -1 -2 -1 ];
for i=K+1:1:row-K-1
    for j=K+1:1:col-K-1
        
         subImg = img(i-K:i+K,j-K:j+K);
         valueX = sum(sum(subImg.*x));
         valueY = sum(sum(subImg.*y));
%        meanValue=mean(subImg(:));
%        img2(i,j)= meanValue;
         img2(i,j)= valueX;
         img3(i,j)= valueY;
    end
end

img = uint8(img);
img2 = uint8(img2);
img3 = uint8(img3);
figure;
subplot(2,2,1);
imshow(img);
subplot(2,2,2);
imshow(img2);
subplot(2,2,3);
imshow(img3)


end
