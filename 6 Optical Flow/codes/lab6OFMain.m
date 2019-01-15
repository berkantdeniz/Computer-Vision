clear all; close all; clc;
% Load the files given in SUcourse as Seq variable
load('sphere.mat');
Seq = sphere;
[row,col,num]=size(Seq);
% Define k and Threshold
k = 10;
Threshold = 4000;
for j=2:1:num
ImPrev = Seq(:,:,j-1);
ImCurr = Seq(:,:,j);
lab6OF(ImPrev,ImCurr,k,Threshold);
pause(0.1);
end