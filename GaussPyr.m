
function pyramid = GaussPyr(img, h, levels); % Input values are image matrix, filter matrix and desired pyramid level depth
    pyramid = {img};
    for i = 1:(levels-1)
        filtered = conv2(img,h,'same');     % Convolve image with the given filter
        sub_img = filtered(1:2:end, 1:2:end);   % Subsample the filtered image
        pyramid{end+1} = sub_img;               % Add resulting image to pyramid
        img = sub_img;                          % Assign image for the next level
    end
end