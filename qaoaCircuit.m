function circuit = qaoaCircuit(N, h, J, params, r) 
    params = reshape(params,[2 r]);
    %[g1 g2 ...
    %[b1 b2 ...
    
    gates = [];
    for j = 1:r
        % Include a cost gate with the specified gamma angle.
        for k = 1:(N)
            for l = 1:(N)
                if l==k  
                    theta = 2 * params(1,j) * J(k,l);
                    gates = [gates; rzGate(l, 2*theta)];
                else 
                    theta = 2 * params(1,j) * J(k,l);
                    Z1 = [
                        1, 0;
                        0, cos(theta)+1i*sin(theta)
                    ];
    
                    U = blkdiag(Z1, Z1); 
    
                    customGate = unitaryGate([k, l], U);
                    gates = [gates; customGate];
                end

            end
            gates = [gates; rzGate(k,2*params(1,j)*h(k))];
        end

        % Include a mixer gate with the specified beta angle.
        gates = [gates; rxGate(1:N,2*params(2,j))];        
    end

    circuit = quantumCircuit([hGate(1:N);gates]);
end
















