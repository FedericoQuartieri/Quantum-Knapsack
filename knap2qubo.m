function QP = knap2qubo(weights, values, P, maxW)

display "QUBO Knapsack"

Q = P * (weights' * weights);
c = -values - 2*P*maxW*weights;

Q = Q + diag(c);

QP = qubo(Q);

end

