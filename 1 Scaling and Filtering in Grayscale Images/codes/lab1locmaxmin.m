function img2 = lab1locmaxmin(img,K)

[row, col, ch] = size(img);
if(ch==3)
    img = rgb2gray(img);
end

img = double(img);

for i=K+1:1:row-K-1
    for j=K+1:1:col-K-1
       subImg = img(i-K:i+K,j-K:j+K);
       maxValue=max(subImg(:));
       minValue=min(subImg(:));
       imgMin(i,j)= minValue;
       imgMax(i,j)= maxValue;
    end
end

img = uint8(img);
imgMin = uint8(imgMin);
imgMax = uint8(imgMax);

figure;
subplot(2,2,1);
imshow(img);
subplot(2,2,2);
imshow(imgMax);
subplot(2,2,3);
imshow(imgMin)




end