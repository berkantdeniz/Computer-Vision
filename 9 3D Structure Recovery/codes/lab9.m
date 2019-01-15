clear all; close all; clc;
%% Definitions
rng(1);
L = 300;
I1 = zeros(L,L);
noiseCoef = 3;
f=L;
u0 = L/2;
v0 = L/2;

K = [f 0 u0;
    0 f v0;
    0 0 1];

DEG_TO_RAD = pi/180;

%% World Coordinates
P_W=[0	2	0	1;
    0	1	0	1;
    0	0	0	1;
    0	2	-1	1;
    0	1	-1	1;
    0	0	-1	1;
    0	2	-2	1;
    0	1	-2	1;
    0	0	-2	1;
    1	0	0	1;
    2	0	0	1;
    1	0	-1	1;
    2	0	-1	1;
    1	0	-2	1;
    2	0	-2	1;
    1	1	0	1;
    2	1	0	1;
    1	2	0	1;
    2	2	0	1];

P_W = P_W';
NPTS = size(P_W,2); %Number of points

%% Visualization   
figure;
subplot(1,3,1)
wally = meshgrid(0:0.1:3); 
wallz = meshgrid(-3:0.1:0); 
wallx = 0*ones(size(wallz,1));
surf(wallx, wally, wallz','FaceColor',(1/255)*[97 178 205],'EdgeColor','none') 
hold on
wallx = meshgrid(0:0.1:3); 
wallz = meshgrid(-3:0.1:0); 
wally = 0*ones(size(wallz,1));
surf(wallx, wally, wallz','FaceColor',(1/255)*[77 137 157],'EdgeColor','none')
wallx = meshgrid(0:0.1:3); 
wally = meshgrid(0:0.1:3); 
wallz = zeros(size(wally,1));
surf(wallx, wally', wallz,'FaceColor',(1/255)*[45 162 200],'EdgeColor','none')
plot3(P_W(1,:),P_W(2,:),P_W(3,:),'b.','MarkerSize',36);
axis equal;
grid on
axis vis3d;
axis([-3 3 -3 3 -3 3])
xlabel('x')
ylabel('y')
zlabel('z')
plot3(P_W(1,:),P_W(2,:),P_W(3,:),'d');
title('Original World Points','FontSize',20)

%% Camera Transformation for View 1
ax = 120 * DEG_TO_RAD;
ay = 0 *DEG_TO_RAD;
az = 60 * DEG_TO_RAD;

Rx = [1 0 0;
      0 cos(ax) -sin(ax);
      0 sin(ax) cos(ax)];
Ry = [cos(ay)  0  sin(ay);
           0   1     0;
      -sin(ay) 0  cos(ay)];
Rz = [cos(az) -sin(az) 0;
      sin(az) cos(az)  0;
      0          0     1];
  
Rc1 = Rx*Ry*Rz;
Tc1 = [0;0;5];
M = [Rc1 Tc1];

p1 = K*(M * P_W);

noise1 = noiseCoef*rand(3,NPTS)-(noiseCoef/2);
noise1(3,:)=1;
p1 = p1 + noise1;

u1(1,:) = p1(1,:) ./ p1(3,:);
u1(2,:) = p1(2,:) ./ p1(3,:);
u1(3,:) = p1(3,:) ./ p1(3,:);

for i=1:length(u1)
    x = round(u1(1,i)); y=round(u1(2,i));
    I1(y-2:y+2, x-2:x+2) = 255;
end

subplot(1,3,2), imshow(I1, []), title('View 1', 'FontSize',20);

%% Camera Transformation for View 2

ax = 0 * DEG_TO_RAD;
ay = -25 *DEG_TO_RAD;
az = 0 * DEG_TO_RAD;

Rx = [1 0 0;
      0 cos(ax) -sin(ax);
      0 sin(ax) cos(ax)];
Ry = [cos(ay)  0  sin(ay);
           0   1     0;
      -sin(ay) 0  cos(ay)];
Rz = [cos(az) -sin(az) 0;
      sin(az) cos(az)  0;
      0          0     1];

Rc2c1 = Rx*Ry*Rz;

Tc2c1 = [3;0;1];
Hc1 = [Rc1 Tc1; 0 0 0 1];
Hc2c1 = [Rc2c1 Tc2c1; 0 0 0 1];
Hc2 = Hc2c1*Hc1;

Rc2 = Hc2(1:3,1:3);
Tc2 = Hc2(1:3,4);

M = [Rc2 Tc2];

I2 = zeros(L,L);
p2 = K*(M*P_W);

noise2 = noiseCoef*rand(3,NPTS)-(noiseCoef/2);
noise2(3,:)=1;
p2 = p2 + noise2;

u2(1,:) = p2(1,:) ./ p2(3,:);
u2(2,:) = p2(2,:) ./ p2(3,:);
u2(3,:) = p2(3,:) ./ p2(3,:);

for i=1:length(u2)
    x = round(u2(1,i)); y=round(u2(2,i));
    I2(y-2:y+2, x-2:x+2) = 255;
end

subplot(1,3,3), imshow(I2, []), title('View 2', 'FontSize',20);

t = Tc2c1;
T_skew = [0 -t(3) t(2); t(3) 0 -t(1); -t(2) t(1) 0];
Etrue = T_skew*Rc2c1;

%% Conversion of pixel points
p1 = inv(K)*u1;
p2 = inv(K)*u2;

%% Estimated variables in Lab#8
E = [0.0019 -0.3304 0.0018; 
    -0.1104 0.0027 -0.9939;
    -0.0045 0.9438 0.0040];

R = [0.9016 0.0030 -0.4325;
    -0.0019 1.000 0.0029;
    0.4326 -0.0018 0.9016];

T = [0.9438; 0.0030; 0.3304];
%% Lab#9 Assignment starts here.
matrix = zeros(NPTS*3,NPTS+1);

for i =1:1:NPTS
tempmatrix = makeskew(p2(:,i)) * R * p1(:,i) ;
matrix(i*3-2,i) = tempmatrix(1,1);
matrix(i*3-1,i) =tempmatrix(2,1);
matrix(i*3,i) =tempmatrix(3,1);
end

for i=1:1:NPTS
tempmatrix = makeskew(p2(:,i)) * T ;
matrix(i*3-2,NPTS+1) = tempmatrix(1,1);
matrix(i*3-1,NPTS+1) = tempmatrix(2,1);
matrix(i*3,NPTS+1) = tempmatrix(3,1);
end
[U S V] = svd(transpose(matrix)*matrix);
lambdas = V(:,20);

matrix2 = zeros(4,19);
for i=1:1:NPTS
matrix2(1,i) = p1(1,i)*lambdas(i);
matrix2(2,i) = p1(2,i)*lambdas(i);
matrix2(3,i) = p1(3,i)*lambdas(i);
matrix2(4,i) = 1;
end

matrix2 = inv(Hc1)*matrix2;

figure;
scatter3(matrix2(1,:),matrix2(2,:),matrix2(3,:));

%% Plot the 3D points
figure
subplot(1,2,1)
plot3(P_W(1,:),P_W(2,:),P_W(3,:),'b.','MarkerSize',36)
axis equal
grid on
axis vis3d
xlabel('X')
ylabel('Y')
zlabel('Z')
title('Original World Points')

subplot(1,2,2)
plot3(matrix2(1,:),matrix2(2,:),matrix2(3,:),'b.','MarkerSize',36)
axis equal
grid on
axis vis3d
xlabel('X')
ylabel('Y')
zlabel('Z')
title('Original World Points')
title('Reconstructed World Points (Up to scale)')




