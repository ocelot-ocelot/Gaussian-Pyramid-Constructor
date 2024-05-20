%%
%img = im2double(imread("lena.png"));
img = im2double(imread("lena.png"));
img = im2gray(img);
img = imresize(img,[512, 512]);

[lenx leny] = size(img);

model = 'haar';
model = 'rbio3.5';

%%
[ll, lh, hl, hh] = dwt2_ccy(img,model,lenx,leny);
%[ll2, lh2, hl2, hh2] = dwt2(ll,model,lenx/2,leny/2);

ll = imresize(ll, [256 256]);
lh = imresize(lh, [256 256]);
hl = imresize(hl, [256 256]);
hh = imresize(hh, [256 256]);


[ll2, lh2, hl2, hh2] = dwt2_ccy(ll,model,lenx/2,leny/2);
%[ll2, lh2, hl2, hh2] = dwt2(ll,model,lenx/2,leny/2);

ll2 = imresize(ll2, [128 128]);
lh2 = imresize(lh2, [128 128]);
hl2 = imresize(hl2, [128 128]);
hh2 = imresize(hh2, [128 128]);

total_mat = zeros(512);

total_mat(1:1:128,1:1:128) = ll2;
total_mat(1:1:128,129:1:256) = hl2;
total_mat(129:1:256,1:1:128) = lh2;
total_mat(129:1:256,129:1:256) = hh2;

total_mat(257:1:512,1:1:256) = lh;
total_mat(1:1:256,257:1:512) = hl;
total_mat(257:1:512,257:1:512) = hh;

rescale(total_mat);
imagesc(total_mat), colormap gray;

