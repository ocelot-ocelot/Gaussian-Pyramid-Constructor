%This function returns the wavelet coefficients for 2-D images
function [ll_mat, lh_mat, hl_mat, hh_mat] = dwt2_ccy(img, model, lenx, leny) 

% Construct the first order coefficient matrices to fill in later
% l_mat = zeros(lenx/2,leny/2);
% ll_mat = zeros(lenx/2,leny/2);
% h_mat = zeros(lenx/2,leny/2);
% lh_mat = zeros(lenx/2,leny/2);

% Get the h and l coefs first
one_time = 1;
for k = 1:leny
    [l_temp, h_temp] = dwt(img(k,:),model); % Take 1-D DWT over the rows
    if one_time == 1 % Runs only one time, construct the coefficient matrices for given image size
        l_size = size(l_temp);
        l_mat = zeros(l_size(2), l_size(2));
        h_mat = l_mat;
        one_time = 0;
    end
    l_mat(k,:) = l_temp; % Add the coefficient values to coefficient matrix
    h_mat(k,:) = h_temp;
end


% Get the ll and lh coefs
one_time = 1;
for l = 1:(lenx/2) % Since image is downsampled over rows above, iteration length is halved
    [ll_temp, lh_temp] = dwt(l_mat(:,l),model); % Take 1-D DWT over the columns
    if one_time == 1 % Runs only one time, construct the coefficient matrices for given image size
        ll_size = size(ll_temp);
        ll_mat = zeros(ll_size(1), ll_size(1));
        lh_mat = ll_mat;
        one_time = 0;
    end
    ll_mat(:,l) = ll_temp; % Add the coefficient values to coefficient matrix
    lh_mat(:,l) = lh_temp;
end
% Get the hl and hh coefs
for l = 1:(lenx/2)
    [hl_temp, hh_temp] = dwt(h_mat(:,l),model);
    if one_time == 1
        hh_size = size(hh_temp);
        hh_mat = zeros(hh_size(1), hh_size(1));
        hl_mat = hh_mat;
        one_time = 0;
    end
    hh_mat(:,l) = hh_temp;
    hl_mat(:,l) = hl_temp;
end
% return the coefs
end