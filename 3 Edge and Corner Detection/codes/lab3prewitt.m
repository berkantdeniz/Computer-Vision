function [img2,img3,img4] = lab3prewitt(img)

[row, col, ch] = size(img);
if(ch==3)
    img = rgb2gray(img);
end

img = double(img);
K=1;
x = [ -1 0 1 ; -1 0 1; -1 0 1 ]; % for vertical edges 
y = [ -1 -1 -1 ; 0 0 0; 1 1 1 ]; % for horizontal edges
for i=K+1:1:row-K-1
    for j=K+1:1:col-K-1
        
         subImg = img(i-K:i+K,j-K:j+K);
         valueX = sum(sum(subImg.*x));
         valueY = sum(sum(subImg.*y));
%        meanValue=mean(subImg(:));
%        img2(i,j)= meanValue;
         img2(i,j)= valueX;
         img3(i,j)= valueY;
         valueGrad = sqrt(valueX^2 + valueY^2);
         img4(i,j) = valueGrad;
         if(valueGrad > 100)
             img5(i,j)=valueGrad;
         end
         
         
         
         
    end
end

img = uint8(img);
img2 = uint8(img2);
img3 = uint8(img3);
img4 = uint8(img4);
figure;
subplot(1,5,1);
imshow(img);
title('Original Image')
subplot(1,5,2);
imshow(img3);
title('Prewitt Horizontal Image')
subplot(1,5,3);
imshow(img2)
title('Prewitt Vertical Image')
subplot(1,5,4);
imshow(img4);
title('Prewitt Gradient Image')
subplot(1,5,5);
imshow(img5);
title('Prewitt Edges Image')





end
