function circuit = qaoaCircuit(N, h, J, params, r) 
    params = reshape(params,[2 r]);
    %[g1 g2 ...
    %[b1 b2 ...
    
    gates = [];
    for j = 1:r
        % Include a cost gate with the specified gamma angle.
        for i = 1:(N-1)
            theta = 2 * params(1,j) * J(i,j);
            Z1 = [
                cos(theta/2),        -1i*sin(theta/2);
                -1i*sin(theta/2),     cos(theta/2)
            ];

            U = blkdiag(Z1, Z1); 

            customGate = unitaryGate([i, i+1], U);

            gates = [gates; customGate];
        end
        gates = [gates; rzGate(1:N,2*params(1,j)*h(j))];
        % Include a mixer gate with the specified beta angle.
        gates = [gates; rxGate(1:N,2*params(2,j))];        
    end

    circuit = quantumCircuit([hGate(1:N);gates]);

    %disp(circuit);
end
















