rng(10)

clear
clc

w = [2 4 5];  
v = [10 35 10];  
capacity = 9;  % Capacità massima  

P = 4* sum(v)*capacity;

numShots = ones(100,1);

bestVal = 1e10;
bestX = 0;
solver = "ansatz";
disp("Solving as")
disp(solver)

if solver == "qubo"
    
    qubo_prob = knap2qubo(w, v, P, capacity);
    
    for i = numShots
        qubo_prob = knap2qubo(w, v, P, capacity);
        result = solve(qubo_prob, Algorithm=qaoa);
    
        if w*result.BestX <= capacity
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

end

if solver == "ansatz"

    optimizedCircuit = knap2ansatz(w,v,P,capacity);
    plot(optimizedCircuit)
    
    disp("DONE")
    sv = simulate(optimizedCircuit);
    histogram(sv)
end