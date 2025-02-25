function QP = knap2qubo(weights, values, P, maxW)

Q = P * kron(weights', weights);

c = -values - 2*P*maxW*weights;
d = 0;

QP = qubo(Q',c,d);

end

