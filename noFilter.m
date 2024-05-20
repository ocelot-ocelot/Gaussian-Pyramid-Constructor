% Subsample function without filtering
function pyramid = noFilter(img, levels); 
    pyramid = {img};
    for i = 1:(levels-1)
        img = img(1:2:end,1:2:end); % Jump every two value
        pyramid{end+1} = img;       % Add the subsampled image to pyramid
    end
end