function [h, J, constant] = qubo_to_ising(Q)
    n = size(Q, 1); 
    J = Q / 4; 
    
    h1 = sum(Q,2);
    h2 = sum(Q,1);

    h = -(h1+h2)/4;
    constant = sum(Q(:)) / 4;
    %J = tril(J, -1);
end