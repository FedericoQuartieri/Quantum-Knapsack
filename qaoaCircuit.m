function circuit = qaoaCircuit(N, h, J, params, r) 
    params = reshape(params,[2 r]);
    %[gamma1 gamma2 ...]
    %[beta1 beta2 ...]
    
    gates = [];
    for j = 1:r
        for k = 1:(N)
            for l = 1:(N)
                theta = 2 * params(1,j) * J(k,l);
                if l==k  % rz gate of second product of cost Hamiltonian applied to a single qubit with double angle
                    gates = [gates; rzGate(l, 2*theta)];

                else  % rzz gate of second product of cost Hamiltonian applied to every pair of qubit
                    
                    %rz gate
                    Z1 = [
                        1, 0;
                        0, cos(theta)+1i*sin(theta)
                    ];
        
                    RZZ = blkdiag(Z1, Z1); 
    
                    customGate = unitaryGate([k, l], RZZ);
                    gates = [gates; customGate];
                end

            end
            % rz gate of first product of the cost Hamiltonian
            gates = [gates; rzGate(k, 2*params(1,j)*h(k))];
        end

        % Include a mixer gate with the specified beta angle.
        gates = [gates; rxGate(1:N,2*params(2,j))];        
    end

    % build and return circuit
    circuit = quantumCircuit([hGate(1:N);gates]);
end
















