function [ deltaCost ] = getDeltaCost(aMatrix, vertex, colors, newColors)
% This is the function were we compute the delta cost for each iteration of
% the Simulated Annealing Algorithm. 

neighbors = logical(aMatrix(vertex, :));

oldPartialCost = sum(colors(vertex) == colors(neighbors));
newPartialCost = sum(newColors(vertex) == newColors(neighbors));

deltaCost = newPartialCost - oldPartialCost;

end

