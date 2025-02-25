function [h, J, constant] = qubo_to_ising(Q)
    n = size(Q, 1); 
    J = Q / 4; 
    h = (diag(Q) / 2) + sum(Q, 2) / 4;
    constant = sum(Q(:)) / 4;
    %J = tril(J, -1);
end