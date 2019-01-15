function img = lab3log(imgOrg)

[row, col, ch] = size(imgOrg);
if(ch==3)
    imgOrg = rgb2gray(imgOrg);
end

imgOrg = double(imgOrg);
img = zeros(size(imgOrg));
img2 = zeros(size(imgOrg));

K=2;
k = (1/273)*[1 4 7 4 1; 4 16 26 16 4; 7 26 41 26 7; 4 16 26 16 4; 1 4 7 4 1 ];

for i=K+1:1:row-K-1
    for j=K+1:1:col-K-1  
         subImg = imgOrg(i-K:i+K,j-K:j+K);
         value = sum(sum(subImg.*k));
         img(i,j)= value;
    end
end



K=1;



l = [0 -1 0; -1 4 -1; 0 -1 0];
for i=K+1:1:row-K-1
    for j=K+1:1:col-K-1
         subImg = img(i-K:i+K,j-K:j+K);
         value2 = sum(sum(subImg.*l));
         img2(i,j)= value2;
    end
end

imgOrg = uint8(imgOrg);




figure;
subplot(1,3,1);
imshow(imgOrg);
subplot(1,3,2);
imshow(img2,[]);
subplot(1,3,3);
plot(img2(20:1:60,100));





end
