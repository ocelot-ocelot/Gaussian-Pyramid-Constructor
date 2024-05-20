
function [] = PyramidPrint(gauss_pyramid)   % Print the gauss pyramid which is given in cell form

pyr_lvl_count = length(gauss_pyramid);      % Get the depth information

figure;
tiledlayout(round(pyr_lvl_count/2),round(pyr_lvl_count/2));  % Construct a figure base for pyramid depth

for i = 1:pyr_lvl_count                     %print the gaussian pyramid images on same figure
    nexttile;
    imshow(gauss_pyramid{i});
    title("LVL-"+num2str(i));
end

end