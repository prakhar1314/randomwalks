%% About the code
% 
% While running this code, you have two options:
% 1) Import matrix from file
% 2) Generate an Erdos-Renyi matrix
% 
% Finding the best coloring of an input graph can be done by running 
% the "Test different values of Q as a function of C". We have also included
% the "Test different functions section", which is where we experimented 
% with the different cooling schedules. 



%% Import from file

A = importdata('graph_adjacency_matrix.mat');
[N_vertices,~] = size(A);
N_steps = 1000;
C = 20;
Q = 3;

colors = randi(Q, N_vertices, 1);

%% Create Erdos-Renyi matrix

N_vertices = 1000;
N_steps = 100000;
C = 20;
Q = 3;

colors = randi(Q, N_vertices, 1);

A = ErdosRenyiMatrix(N_vertices, C);


%% Test different functions
B_inits = [100];
func_values = [8 9 10 11];
no_lines = length(B_inits) * length(func_values);
cost_arrays = zeros(no_lines, N_steps + 1);
resultColors = zeros(no_lines, N_vertices);

for i=1:length(B_inits)
    for j=1:length(func_values)
        [cost_arrays((i-1)*length(func_values)+j,:), resultColors((i-1)*length(func_values)+j,:), ~, ~] = SimulatedAnnealing(A, C, Q, colors, N_vertices, N_steps, B_inits(i), func_values(j));
    end
end

figure(2);
plot(cost_arrays.');
labels = strtrim(cellstr(num2str(func_values'))');
legend(labels, 'Location','northeast');
xlabel('$c \in \{1, N \}$','Interpreter','LaTex');
ylabel('$H(x^t)$', 'Interpreter', 'LaTex');

reshape(cost_arrays(:,end), [length(func_values) length(B_inits)])


%% Test different values of Q as a function of C

Qs = [3 4 5 6 7];
Cs = linspace(1, N_vertices, 20);

colors = zeros(N_vertices, 1);

QC = zeros(length(Qs), length(Cs));

for q = 1:length(Qs)
    colors = randi(Q, N_vertices, 1);
    for c = 1:length(Cs)
        A = ErdosRenyiMatrix(N_vertices, Cs(c));
        
        [~, ~, bestCost, ~] = SimulatedAnnealing(A, Cs(c), Qs(q), colors, N_vertices, N_steps, 0, 11);
        QC(q, c) = bestCost;
    end
end

figure(3);

for q=1:length(Qs)
    plot(Cs, QC(q,:)); hold on;
end
hold off;
labels = strtrim(cellstr(num2str(Qs'))');
legend(labels, 'Location','northeast');
title('Erdos-Renyi random graph, $N = 1000$' ,'Interpreter','LaTex');
xlabel('$c \in \{1, N \}$','Interpreter','LaTex');
ylabel('$H{min}$','Interpreter','LaTex');

