rng(10)

clear
clc

w = [2 2 2];  % weights
v = [10 10 10]; % values
capacity = 12345;  % maximum capacity  
P = 4* sum(v)*capacity; % penalty
numShots = ones(100,1); 
solver = "ansatz"; % which solver to use



bestVal = 1e10;
bestX = 0;

%--------------solving with qubo-------------
if solver == "qubo"  
    for i = numShots
        qubo_prob = knap2qubo(w, v, P, capacity);
        result = solve(qubo_prob, Algorithm=qaoa); 
    
        
        if w*result.BestX <= capacity % verify constraints satisfaction
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


%-----------solving with ansatz-------------
if solver == "ansatz"

    optimizedCircuit = knap2ansatz(w,v,P,capacity); % computing circuit
    plot(optimizedCircuit)
    
    sv = simulate(optimizedCircuit);
    histogram(sv)
    meas = randsample(sv,1000);

    [states, probabilities] = querystates(meas);
    [maxValue, index] = max(probabilities);
    states_matrix = double(char(states) == '1');
    bestX = states_matrix(index, :);

    disp("bestX = ");
    disp(bestX);

    disp("bestValue = ");
    disp(bestX*v');




end