function Flattened = five_flattening(Source)
% FIVE_FLATTENING
% texture flattening for RGB image
%
% input:
%    Source: a RGB colour image
%       e.g. Source = imread('to_flat','png');
%
% Output: 
%   Image: texture-flatten selected region in Source


Source = im2double(Source);

% All: select ROI and create mask
figure
imshow(Source);
Mask = im2double(createMask(drawfreehand()));

imshow(Mask);

% separate colour image to 3 channels
[IR,IG,IB] = imsplit(Source);

% texture flattening in each channel
FR = flat_ch(IR,Mask);
FG = flat_ch(IG,Mask);
FB = flat_ch(IB,Mask);

% combine the three channels
Flattened = cat(3, FR,FG,FB);
figure
imshow(Flattened);

end