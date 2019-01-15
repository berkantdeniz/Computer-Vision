function img2= lab3ktcorners(img)
[row, col, ch] = size(img);
if(ch==3)
    img = rgb2gray(img);
end
img = double(img);
img2 = zeros(size(img));

[Gx,Gy] =  imgradientxy(img);
K=1;

corners = [];
for i=K+1:10:row-K-1
    for j=K+1:10:col-K-1  
         
Gsubx = Gx(i-K:i+K,j-K:j+K);
Gsuby = Gy(i-K:i+K,j-K:j+K);
        a=sum(sum(Gsubx.*Gsubx));
        b=sum(sum(Gsubx.*Gsuby));
        c=sum(sum(Gsuby.*Gsuby));
        
         H = [ a b ; b c ];
         
         eigs = eig(H);
         if(min(eigs) > 200 )
           corners = [corners; i j];
         end
    
    end
end

     img = uint8(img);

         
         figure;
         imshow(img);
         hold on;
         plot(corners(:,2),corners(:,1),'r*');


end
