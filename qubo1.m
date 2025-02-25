display "QUBO Knapsack"

rng(10)

w = [2 4 5 6 9];  
v = [10 20 35 30 65];  
maxW = 11;  % Nuova capacità massima  

P = 2*maxW;
Q = kron(w', w);

numShots = ones(100,1);

bestVal = 1e10;
bestX = 0;
qubo_prob = knap2qubo(w, v, P, maxW);

for i = numShots
    qubo_prob = knap2qubo(w, v, P, maxW);
    result = solve(qubo_prob, Algorithm=qaoa);
    if w*result.BestX <= maxW
        if result.BestFunctionValue < bestVal
            fprintf('Improved! %.2f -> %.2f\n', bestVal, result.BestFunctionValue)
            bestVal = result.BestFunctionValue;
            bestX = result.BestX;
        end
    end
end

if bestVal == 1e10
    disp("solution not found");
else 
    disp("BestX = ")
    disp(bestX')
   
    bestFunc = v*bestX;
    fprintf("Best obj. value = %.2f\n", bestFunc)
end
