

%%
img = im2double(imread("gorilla.jpg"));                                            %read the image
img = rgb2gray(img);

im_size = size(img);
img = imresize(img, [im_size(1)-mod(im_size(1),2)-1 im_size(2)-mod(im_size(2),2)-1]);  %resize the image for less error


h = fspecial('gaussian',9,10);                                              %define gaussian filter

boxcar = (1/9)*ones(1,9);                                                   %define boxcar filter
boxcar_2d = conv2(boxcar,transpose(boxcar));


gauss_pyramid = GaussPyr(img,h,4);                                          %construct 4 level gaussian pyramid
boxcar_pyramid = GaussPyr(img, boxcar_2d,4);                                %construct 4 level boxcar pyramid
no_filter_pyramid = noFilter(img,4);                                                % Get 4 level pyramid with no filtering

PyramidPrint(gauss_pyramid);
PyramidPrint(boxcar_pyramid);
PyramidPrint(no_filter_pyramid);
%%

img = im2double(imread("brokoli.jpg"));                                            %read the image
imresize(img, [512 512]);
img = rgb2gray(img);

laplace_pyramid_default = LaplacePyr(img,h,4,'linear');                     %construct 4 level laplace pyramid with linear interpolation
laplace_pyramid_bilinear = LaplacePyr(img,h,4,'bilinear');
laplace_pyramid_spline = LaplacePyr(img,h,4,'spline');
laplace_pyramid_nearest = LaplacePyr(img,h,4,'nearest');

nearest_inter = interp2(cell2mat(laplace_pyramid_nearest(4)),3,'nearest');    % Interpolate the smallest image by 8, using nearest interpolation
spline_inter = interp2(cell2mat(laplace_pyramid_spline(4)),3,'spline');         % Interpolate the smallest image by 8 using spline interpolation
bilinear_inter = interp2(cell2mat(laplace_pyramid_bilinear(4)),3,'bilinear');   % Interpolate the smallest image by 8 using bilinear interpolation

%Plot the image interpolated by different techniques
figure;
imagesc(nearest_inter), colormap gray;
title("Nearest Interpolation");

figure;
imagesc(spline_inter), colormap gray;
title("Spline Interpolation");

figure;
imagesc(bilinear_inter), colormap gray;
title("Bilinear Interpolation");

%%
% Show the perfectly constructed images
saved_nearest = reconstructor(laplace_pyramid_nearest,'nearest',4);
figure;
imagesc(saved_nearest), colormap gray;
title("Reconstucted using Nearest");

saved_spline = reconstructor(laplace_pyramid_spline,'spline',4);
figure;
imagesc(saved_spline), colormap gray;
title("Reconstucted using Bicubic-Spline");

saved_bilinear = reconstructor(laplace_pyramid_bilinear,'bilinear',4);
figure;
imagesc(saved_bilinear), colormap gray;
title("Reconstucted using Bilinear");

%%
% Note that the function is implemented for the powers of 2, and example is
% given above for 512x512 image
%img = im2double(imread("lena.png"));
user_size = [2048, 2048];
img = im2double(imread("mandrill.jpg"));
img = im2gray(img);
img = imresize(img,[512, 512]);

% Select the function family
prompt = "Select Wavelet Family. 1 For Haar, 2 for rbio3.5: ";
x = input(prompt);
if x == 1
    model = 'haar';
elseif x == 2
        model = 'rbio3.5';
else
    fprintf("Incorrect input, contiuning with haar family.");
end


[lenx leny] = size(img);
[ll, lh, hl, hh] = dwt2_ccy(img,model,lenx,leny);                           % get the ll, lh, hl, hh for given image and function family

%Uncomment to see dwt2_ccy function output is same as dwt2
%[ll2, lh2, hl2, hh2] = dwt2(ll,model,lenx/2,leny/2); 


ll = imresize(ll, [256 256]);
lh = imresize(lh, [256 256]);
hl = imresize(hl, [256 256]);
hh = imresize(hh, [256 256]);


[ll2, lh2, hl2, hh2] = dwt2_ccy(ll,model,lenx/2,leny/2);                    % get the ll2, lh2, hl2, hh2 for given image and function family
%[ll2, lh2, hl2, hh2] = dwt2(ll,model,lenx/2,leny/2);

ll2 = imresize(ll2, [128 128]);
lh2 = imresize(lh2, [128 128]);
hl2 = imresize(hl2, [128 128]);
hh2 = imresize(hh2, [128 128]);

total_mat = zeros(512);                                                     % Create an empty matrix to show all images in one

% Add the images to same matrix
total_mat(1:1:128,1:1:128) = ll2;                               
total_mat(1:1:128,129:1:256) = hl2;
total_mat(129:1:256,1:1:128) = lh2;
total_mat(129:1:256,129:1:256) = hh2;

total_mat(257:1:512,1:1:256) = lh;
total_mat(1:1:256,257:1:512) = hl;
total_mat(257:1:512,257:1:512) = hh;

rescale(total_mat);

figure;
imagesc(total_mat), colormap gray;                                          % Plot the resulting image
title("Wavelet Image Family - Colormap Gray");
figure;
imagesc(total_mat), colormap prism;                                         % Different colormap for low frequency vision
title("Wavelet Image Family - Colormap Prism");