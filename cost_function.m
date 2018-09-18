function [ cost ] = cost_function(A, x)
% Computation of the cost of a particular coloring x of the graph A.

cost = 0;
[h,~] = size(A);

for vertex = 1:h
    color = x(vertex);
    row = A(vertex, :);
    matching_colors = x(logical(row));
    
    cost = cost + nnz(matching_colors==color);

end

cost = cost / 2;