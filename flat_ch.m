function Channel = flat_ch(Channel,Mask)
% CHANNEL
% helper function for five_flattening, texture-flatten each colour channel
%
% input:
%    Channel: a grayscale image
%    Mask: binary image masking region of interest
%
% Output: 
%   Image: texture-flatten selected region in Channel


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
   b(q) = b(q) + Channel(shifted(q));
   
   % add vector using edge detector 
   p_edge = edge(Channel(p),'approxcanny');
   n_edge = edge(Channel(shifted),'approxcanny');
   % p = 1, where p or it's k-neighbour is on edge
   edges = p_edge | n_edge;
   edge_idx = find(edges);
   b(edge_idx) = b(edge_idx) + Channel(p(edge_idx)) - Channel(shifted(edge_idx));
end

x = A\b;
 
Channel(p) = x;
% figure; imshow(Channel);
end

