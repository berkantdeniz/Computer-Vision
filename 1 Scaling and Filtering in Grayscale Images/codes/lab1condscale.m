function imgJnew = lab1condscale(imgJ,imgI)

[row, col, ch] = size(imgJ);
[row2, col2, ch2] = size(imgI);
if(ch==3)
    img = rgb2gray(imgJ);
end
if(ch2==3)
    img2 = rgb2gray(imgI);
end

imgJ = double(imgJ);
imgI = double(imgI);

meanJ = mean(imgJ(:));
meanI = mean(imgI(:));
stdJ = std(imgJ(:));
stdI = std(imgI(:));

a = (meanI*(stdJ/stdI))-meanJ;
b = (stdI/stdJ);

imgJnew = b.*(imgJ +a);

imgJ = uint8(imgJ);
imgJnew = uint8(imgJnew);
imgI = uint8(imgI);

figure;
subplot(2,3,1);
imshow(imgJ);
subplot(2,3,2);
imshow(imgJnew);
subplot(2,3,3);
imshow(imgI)
subplot(2,3,4);
imhist(imgJ)
subplot(2,3,5);
imhist(imgJnew)
subplot(2,3,6);
imhist(imgI)


end