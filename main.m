%------------------------------------------------------------------------------
% Comment 2 lines for testing with source image and transformation matrices
%------------------------------------------------------------------------------
%src = imread("img/target_img.png");
%src = im2gray(src);
%------------------------------------------------------------------------------
% Comment out 2 lines for testing with source image and transformation matrices
%------------------------------------------------------------------------------
src = imread("img/source.jpg");
src = rgb2gray(src);

src = im2double(src);

%------------------------------------------------------------------------------
% 4 Arbitrary Transformation Matrices for Testing
%------------------------------------------------------------------------------
H_0 = [1 0.1 0; 0.2 0.8 3; 0 0 1];
%H_0 = [1 0 0; -0.45 1 0; 0 0 1];
%H_0 = [1 0.1 2; 0.2 0.7 3; 0 0 1];
%H_0 = [1 0 0; 0 1 10; 0 0 1];

%------------------------------------------------------------------------------
% Comment out 3 lines for testing with source image and transformation matrices
%------------------------------------------------------------------------------
transformed = geotrans(H_0, src);
src_cropped = imcrop(src, [25, 25, 99, 99]);
t_cropped = imcrop(transformed, [25, 25, 99, 99]);

%------------------------------------------------------------------------------
% Comment out 5 lines for testing with source image and transformation matrices
%------------------------------------------------------------------------------
%transformed = imread("img/distorted_img_A.png");
%transformed = im2gray(transformed);
%transformed = im2double(transformed);
%src_cropped = imcrop(src, [17, 17, 99, 99]);
%t_cropped = imcrop(transformed, [17, 17, 99, 99]);

% Coordinates from -N/2 to N/2
x0 = [-50:49];
y0 = [-50:49];

% Centered X coordinate for each pixel
X = [];
for i = 1: 100
    X = [X; x0(i) * ones(1, 100)];
end

% Centered Y coordinate for each pixel
Y = [];
for i = 1: 100
    Y = [Y y0(i) * ones(100, 1)];
end

% Initializing iterative image and iteration parameter
res = t_cropped;
it = 1;

% Initializing iterative transformation matrix
H = [1 0 0; 0 1 0; 0 0 1];

while (it < 100)
    % Gradient calculation
    [fx, fy] = gradient(res, 2);
    
    % Calculation of 6 distortion and translation parameters
    [A, b] = design(res,src_cropped,fx,fy,X,Y);
    z = pinv(A) * b';
    
    % New translation matrix for current iteration
    H = H * [1+z(1) z(2) z(5);
         z(3) 1+z(4) z(6);
         0 0 1];

    % Applying this transformation to the iterated image
    res = geotrans(H,t_cropped);
    
    it = it+1;
end

subplot(1,3,1)
imshow(src_cropped)
title('Original Cropped Image')

subplot(1,3,2)
imshow(t_cropped)
title('Transformed Cropped Image')

subplot(1,3,3)
% Applying final transformation matrix to see the final result
res = geotrans(H,t_cropped);
imshow(res)
title(it + "th Iteration")