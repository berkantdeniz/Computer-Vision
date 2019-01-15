function lab6OF(ImPrev,ImCurr,k,Threshold)
% Smooth the input images using a Box filter
filt = ones(3,3);
ImPrev = conv2(ImPrev,filt);
ImCurr = conv2(ImCurr,filt);
% Calculate spatial gradients (Ix, Iy) using Prewitt filter

xp = [ -1 0 1 ; -1 0 1; -1 0 1 ]; % for vertical edges 
yp = [ -1 -1 -1 ; 0 0 0; 1 1 1 ]; % for horizontal edges

Gx = conv2(ImPrev,xp);
Gy = conv2(ImCurr,yp);

%&[Gx,Gy] =  imgradientxy(ImCurr);

% Calculate temporal (It) gradient
It = ImPrev - ImCurr;

[ydim,xdim] = size(ImCurr);
Vx = zeros(ydim,xdim);
Vy = zeros(ydim,xdim);
G = zeros(2,2);
b = zeros(2,1);
cx=k+1;
for x=k+1:k:xdim-k-1
cy=k+1;
for y=k+1:k:ydim-k-1
% Calculate the elements of G and b

Ix = Gx(y-k:y+k,x-k:x+k);
Iy = Gy(y-k:y+k,x-k:x+k);

SubIt = It(y-k:y+k,x-k:x+k);

        a=sum(sum(Ix.*Ix));
        b=sum(sum(Ix.*Iy));
        c=sum(sum(Iy.*Iy));
        
         H = [ a b ; b c ];
         eigs = eig(H);
        
         b = [ sum(sum(Ix.*SubIt)) ; sum(sum(Iy.*SubIt))];
if (min(eigs) < Threshold)
Vx(cy,cx)=0;
Vy(cy,cx)=0;
else
% Calculate u
u=-inv(H)*b;
Vx(cy,cx)=u(1);
Vy(cy,cx)=u(2);
end
cy=cy+k;
end
cx=cx+k;
end
cla reset;
imagesc(ImPrev); hold on;
[xramp,yramp] = meshgrid(1:1:xdim,1:1:ydim);
quiver(xramp,yramp,Vx,Vy,10,'r');
colormap gray;
end