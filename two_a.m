function T = two_a(Source,Target,ImMask,to_where)
% TWO_A
% Seamless cloning for grayscale image using importing gradient
%
% Input: 
%   Source Image and Target Image
%   e.g. Source = rgb2gray(imread('Q2_3_Input','png'));
%        Target = rgb2gray(imread('Q2_3_Input','png'));
%
%   Optional(in convenience of external call): 
%   ImMask: binary image masking region of interest
%   to_where: array [x,y] denoting position to paste in target  
%
% Output: 
%   Image: Cloned selected region from Source into Target(printed)


% fetch region of interest and pasting location in target
if (nargin == 4)
   Mask = ImMask;
   to_x = to_where(1);
   to_y = to_where(2);
elseif (nargin == 2) 
    figure
    imshow(Source);
    Mask = im2double(createMask(drawfreehand()));
    figure
    imshow(Target);
    [to_x,to_y] = ginput(1); 
end    

% imshow(Mask);

% formatting image
S = im2double(Source);
T = im2double(Target);

% index of inteior points
p = find(Mask);

% x,y axies -> matrix subscriopting, intergers only for manipulation
to_row = round(to_y);
to_col = round(to_x);

% size of  target
[target_row,target_col,~] = size(T);

% size of the frame containing mask 
[m_x,m_y] = find(Mask);
m_frame = [max(m_x)-min(m_x),max(m_y)-min(m_y)];

% if cloned mask out of range, then to as far as it can get
% use -1 as need space for neighbours(might out of range)
if m_frame(1) + to_row > target_row
    to_row = target_row - m_frame(1)-1;
end    

if m_frame(2) + to_col > target_col
    to_col = target_col - m_frame(2)-1;
end    

% find index of points in f(in T)
[sx,sy] = find(Mask);
% find index of points in row/col in T
sx1 = (sx - min(sx) + to_row);
sy1 = (sy - min(sy) + to_col);

% convert to index of each point in T
p_target = sub2ind(size(T), sx1, sy1);

% Constructing Matrices
Mask(p) = 1:length(p);
A = delsq(Mask);
[m,~] = size(Mask);
b = zeros(size(p));

for k = [-1 m 1 -m]
   m_shifted = p + k;
   t_shifted = p_target + k; 
   Q = Mask(m_shifted);
   q = find(~Q); 
   % take pixels on-boundary k-neighbours from T
   b(q) = b(q) + T(t_shifted(q));
   % importing gradients
   b = b + S(p) - S(p+k);
end

x = A\b;

T(p_target) = x;
figure
imshow(T);

end

