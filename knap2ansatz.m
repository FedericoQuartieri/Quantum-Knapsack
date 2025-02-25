function QP = knap2qubo(weights, values, P, maxW)

display "Ansatz Knapsack"

Q = P * kron(weights', weights);

[h, J, constant] = qubo_to_ising(Q);


