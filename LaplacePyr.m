function pyramid = LaplacePyr(img, h, levels, mode); % Input values are image matrix, filter matrix, desired pyramid level depth and interpolation mode
    pyramid = {};
    for i = 1:(levels-1)
        filtered = imfilter(img,h,'same');          % Filter the image       
        filtered = filtered(1:2:end,1:2:end);       %Subsample the image by 2
        size_2d = size(img);
        filtered_interpol = imresize(interp2(filtered,1,mode),size_2d); % Fit the size due to different function families 
        pyramid{end+1} = img - filtered_interpol;                       % Add difference image to the pyramid
        img = filtered;
    end
    pyramid{end+1} = img;                                               % Add the last image (LL2) to pyramid
end