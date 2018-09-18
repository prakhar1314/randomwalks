function [ A ] = ErdosRenyiMatrix(N, C)
% Create a random matrix of density C/N

    A = zeros(N);

    for i = 1:N
        for j = i+1:N
            if rand() < C / N
                A(i, j) = 1;
                A(j, i) = 1;
            end
        end
    end

end

