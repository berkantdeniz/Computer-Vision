function img2 = lab1linscale(img)


[row, col, ch] = size(img);
if(ch==3)
    img = rgb2gray(img);
end

% img = imread('city.png');

% img = rgb2gray(img);
img = double(img);

umin=min(img(:));
umax=max(img(:));
Gmax = 255;


a = -umin;
b = Gmax/(umax-umin);

img2 = b.*(img+a);
% 
img2 = uint8(img2);
img = uint8(img);
figure;
subplot(2,2,1);
imshow(img);
subplot(2,2,2);
imshow(img2);
subplot(2,2,3);
imhist(img)
subplot(2,2,4);
imhist(img2)

end