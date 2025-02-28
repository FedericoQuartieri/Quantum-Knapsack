function [h, J, constant] = qubo_to_ising(Q)
    n = size(Q, 1); 
    J = Q; 
    
    h1 = sum(Q,2); % Sum over j of q_ij
    h2 = sum(Q,1); % Sum over j of q_ji
    h = -(h1+h2);

    constant = sum(Q(:));
end