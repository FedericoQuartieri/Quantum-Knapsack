function expVal = expectedObjectiveValue(N, h, J, values, theta, numLayers,numShots)
    % Create and simulate the QAOA circuit.
    circuit = qaoaCircuit(N, h, J,theta,numLayers);
    sv = simulate(circuit);
    
    % Measure circuit numShots times.
    meas = randsample(sv,numShots);

    [states, probabilities] = querystates(meas);

    states_matrix = double(char(states) == '1');

    disp(size(probabilities))

    expVal = probabilities'*states_matrix * values'


    disp(expVal);

end

