display "QUBO Knapsack"

w = [10 20 30 5];
v = [60 100 120 30];

maxW = 50;
P = min(w);

Q = kron(w', w);

qubo_prob = knap2qubo(w, v, P, maxW);

result = solve(qubo_prob, Algorithm=qaoa);

result.BestX
bestFunc = result.BestFunctionValue;

- bestFunc + (P/maxW)* result.BestX'*Q*result.BestX
