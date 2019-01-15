ImLeft = imread('S01R.png');
ImRight = imread('S01L.png');



[row, col, ch] = size(ImLeft);

ImLeft = rgb2gray(ImLeft);
ImRight = rgb2gray(ImRight);







% imshow(stereoAnaglyph(ImLeft,ImRight));
ImLeft = double(ImLeft);
ImRight = double(ImRight);

ImLeft =   padarray(ImLeft,[60 60],'both');
ImRight =   padarray(ImRight,[60 60],'both');


K=10; % window size


% for i=K+1:1:row-K-1
%     for j=K+1:1:col-K-1
dispar = zeros(size(ImLeft));

for i=K+1:1:row-K-1
    for j=K+1:1:col-K-1
           
        dist=[];
        subL = ImLeft(i-K:i+K,j-K:j+K);
     
       for t = 0:1:60
           subR = ImRight(i-K:i+K,j-K+t:j+K+t);
           
           SSD = sum(sum(subL-subR).^2);
           dist = [dist; j j+t SSD];
       end
       
%         
          ind = find(dist(:,3) == min(dist(:,3)));
          ind = ind(1);
          displ = dist(ind,2)-dist(ind,1);
          dispar(i,j) = displ;
          
    end
end

dispar = uint8(dispar);
figure; imagesc(dispar); colormap jet; colorbar
