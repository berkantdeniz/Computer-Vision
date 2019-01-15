clear all; close all; clc;
load('faces.mat');
Seq = faces;
[row,col,num]=size(Seq);
%Image=uint8(reshape(Seq, [row,col]));

train = Seq(:,1:360);
train = double(train) / 255;
test = Seq(:,361:400);
test = double(test) / 255;


xbar = mean(train');
xbar = xbar';


A = train-xbar;
K = 100;
[V,D] = eigs(A'*A,K);

newV = (A*V)/norm(A*V);

exampleimg = test(1:2576,20);

a = [];
minia = exampleimg-xbar;
%minia = minia;
for i = 1:1:100
b = dot(minia,newV(:,i));
a = [a b];
end
reconstruct = xbar + (a*newV')';


error = norm(exampleimg - reconstruct);
disp(error);

exampleimg = reshape(exampleimg,56,46);
reconstruct = reshape(reconstruct,56,46); 
figure;
subplot(1,2,1)
imshow(exampleimg);
subplot(1,2,2)
imshow(reconstruct);
if(error>7.000)
    disp('not face');
else
    disp('face');
end
%%%%%% difference of exampleimg and reconstruct will give reconstruction
%%%%%% error
% 
%training = train(1:2576,1:360);
%eigenfaceVec = training'*newV;

eigenfaceVec = [];
for i=1:1:360
    x = train(:,i); % Test face
    diffx = x - xbar;
    dbrow = [];
    for j=1:1:K
        smalla = dot(diffx, newV(:,j));
        dbrow = [dbrow smalla];
    end
    eigenfaceVec = [eigenfaceVec; dbrow];
end



[row,col] = size(eigenfaceVec);
matrix= [];
for i = 1:1:360
    sum = 0;
    for j = 1:1:K
        sum = sum + (eigenfaceVec(i,j) - a(j))^2;
    end 
    sum = sqrt(sum);
    matrix = [matrix;sum];
end
%minval = min(matrix);
ind = find(matrix(:) == min(matrix(:)));

foundimg = train(1:2576,ind);
foundimg = reshape(foundimg,56,46);
figure;
subplot(1,2,1)
imshow(exampleimg);
subplot(1,2,2)
imshow(foundimg);

