function Filled = one_fill(Source)
% ONE_FILL 
% Removes and refill selected region with membrane interpolant
% Input: 
%   Source: a colour image
%   e.g. Source = rgb2gray(imread('Q1_Input','png'));
% Output: 
%   The refilled Image(printed)


S = im2double(Source);


% Select region of interest
figure
imshow(S);
Mask = im2double(createMask(drawfreehand()));

% for one_fill: remove selected region
removed = (1 - Mask).* S;
imshow(removed);

% Indices of interior points
p = find(Mask);

% Construct the left-hand side matrix
Mask(p) = 1:length(p);
A = delsq(Mask);

% Construct right-hand side 
% b agrees to length of p
b = zeros(size(p));
[m,~] = size(Mask);

% in four directions: Up,Right,Down,Left
for k = [-1 m 1 -m]
   % index(in Mask) of shifted ROI
   shifted = p + k;
   % pixel values of shifted ROI 
   Q = Mask(shifted);
   % Index(in shifted) of on-boundary neighbours(at 0's), also
   % Index(in p or b) of interior points with on-boundary neighbours
   q = find(~Q); 
   % add to b the pixel values of it's neighbours(in S)
   b(q) = b(q) + S(shifted(q));
end

x = A\b;
 
Filled = S; 
Filled(p) = x;
figure;
imshow(Filled);

end

