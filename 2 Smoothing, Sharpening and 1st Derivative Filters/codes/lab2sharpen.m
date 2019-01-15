function [img3, img4] = lab2sharpen(img,lamba,M)

[row, col, ch] = size(img);

if(ch==3)
    img = rgb2gray(img);
end
img2 = zeros(size(img));

K=2;
if(M == 1)
    for i=K+1:1:row-K-1
        for j=K+1:1:col-K-1
            subImg = img(i-K:i+K,j-K:j+K);
            meanValue=mean(subImg(:));
            img2(i,j)= meanValue;
        end
    end
end

if(M==2)
    
    img2 = lab2gaussfilt(img);
end

if(M==3)
    img2 =  lab2medfilt(img,2);
end

img = double(img);
img2 = double(img2);

img4 = img2;
img3 = img - lamba.*(img-img2);

img3 = uint8(img3);
img2 = uint8(img2);
img = uint8(img);

figure;
subplot(3,3,1);
imshow(img);
subplot(3,3,2);
imshow(img2);
subplot(3,3,3);
imshow(img3);



end
