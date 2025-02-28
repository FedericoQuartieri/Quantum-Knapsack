function expVal = expectedObjectiveValue(N, h, J, values, weights, P, maxW, theta, numLayers,numShots)
    % Create and simulate the QAOA circuit.
    circuit = qaoaCircuit(N, h, J,theta,numLayers);
    sv = simulate(circuit);
    
   
    meas = randsample(sv,numShots); % Measure circuit numShots times.

    [states, probabilities] = querystates(meas);

    numStates = size(states, 1);
    states_matrix = double(char(states) == '1');
    
    form = 1;

    %----------first way of computing value-----

    if form == 0
    
        
        offsetWeights = (states_matrix*weights'- ones(numStates,1)*maxW);
        objVector = states_matrix*values' - P* offsetWeights.*offsetWeights;
       
        
        expVal = probabilities' * objVector;
    end

    %----------second way of computing value-----


    if form == 1

        expVal = 0;
       
        for i = 1:size(probabilities,1)
            f = states_matrix(i, :)*values';
            constraints = (states_matrix(i,:)*weights'-maxW)^2;
            value = (f-P*constraints);
            expVal = expVal + probabilities(i)*value;
            
        end
    end

    
    % both methods seem to provide the same answer

    % in both cases, the value is computed by extracting the value of the 
    % function to maximize (actual function and penalty) for each possible
    % state.
    % Then multiplying by their probability, we obtain an average of 
    % the objective values of possible states weighted by their probabilities.
    

end

