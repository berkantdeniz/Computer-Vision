function img2 = lab1locbox(img,K)

[row, col, ch] = size(img);
if(ch==3)
    img = rgb2gray(img);
end

img = double(img);

for i=K+1:1:row-K-1
    for j=K+1:1:col-K-1
       subImg = img(i-K:i+K,j-K:j+K);
       meanValue=mean(subImg(:));
       img2(i,j)= meanValue;
    end
end

img = uint8(img);
img2 = uint8(img2);
figure;
subplot(2,2,1);
imshow(img);
subplot(2,2,2);
imhist(img);
subplot(2,2,3);
imshow(img2)
subplot(2,2,4);
imhist(img2)

end
