display "QUBO Knapsack"

rng(10)

w = [1 3 4 5 8];
v = [15 40 50 70 85];

maxW = 10;

P = maxW;
numShots = ones(100,1);

bestVal = 1e10;
bestX = 0;
for i = numShots
    qubo_prob = knap2qubo(w, v, P, maxW);
    result = solve(qubo_prob);

    if result.BestFunctionValue < bestVal
        fprintf('Improved! %.2f -> %.2f\n', bestVal, result.BestFunctionValue)
        bestVal = result.BestFunctionValue;
        bestX = result.BestX;
    end
end

disp("BestX = ")
disp(bestX')

bestFunc = result.BestFunctionValue;

- bestFunc + (P/maxW)* result.BestX'*Q*result.BestX
