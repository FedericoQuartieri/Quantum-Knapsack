function expVal = expectedObjectiveValue(N, h, J, values, weights, P, maxW, theta, numLayers,numShots)
    % Create and simulate the QAOA circuit.
    circuit = qaoaCircuit(N, h, J,theta,numLayers);
    sv = simulate(circuit);
    
    % Measure circuit numShots times.
    meas = randsample(sv,numShots);

    [states, probabilities] = querystates(meas);

    numStates = size(states, 1);
    states_matrix = double(char(states) == '1');
    
    form = 1;

    if form == 0
    
        scaled_states_matrix = probabilities'*states_matrix;
        
        offsetWeights = (states_matrix*weights'- ones(numStates,1)*maxW);
        objVector = states_matrix*values' - P* offsetWeights.*offsetWeights;
        
        expVal = probabilities' * objVector;
    end

    if form == 1

        expVal = 0;
       
        for i = 1:size(values)
            f = states_matrix(i, :)*values';
            constraints = (states_matrix(i,:)*weights'-maxW)^2
            expVal = expVal + probabilities(i)*(f-P*constraints)
        end
    end

    % expVal = probabilities'*states_matrix * values' - P*((states_matrix * weights' - ones(numStates,1)*maxW))^2;
    
    disp("EXP VAL")
    disp(expVal);

end

