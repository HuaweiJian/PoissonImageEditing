function C = three_rgb(Source,Target)
% THREE_RGB
% Seamless cloning for RGB image from importing gradient 
% Input: 
%   Source Image and Target Image
%   e.g. Source = imread('Q2_3_Input','png');
%        Target = Source;
% Output: 
%   Image: Cloned selected region from Source into Target(printed)

Source = im2double(Source);
Target = im2double(Target);

% select ROI and create mask
figure
imshow(Source);
ImMask = im2double(createMask(drawfreehand()));

% select position to clone
figure
imshow(Target);
% select the top-left point
to_where = ginput(1); 

% imshow(ImMask);

% separate colour image to 3 channels
[SR,SG,SB] = imsplit(Source);
[TR,TG,TB] = imsplit(Target);
% conduct two_a
CR = two_a(SR,TR,ImMask,to_where);
CG = two_a(SG,TG,ImMask,to_where);
CB = two_a(SB,TB,ImMask,to_where);

% combine the three channels
C = cat(3, CR,CG,CB);
figure
imshow(C);
end

