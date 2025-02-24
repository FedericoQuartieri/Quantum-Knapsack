display "QUBO Knapsack"

w = [10 20 30 5];
v = [60 100 120 30];

maxW = 50;
P = max(w);

Q = kron(w', w);

qubo_prob = knap2qubo(w, v, P, maxW);

result = solve(qubo_prob, Algorithm=qaoa);

result.BestX
result.BestFunctionValue