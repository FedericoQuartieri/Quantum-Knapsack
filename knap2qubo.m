function QP = knap2qubo(weights, values, P, maxW)

Q = P/maxW * kron(weights', weights);

c = -values;
d = 0;

QP = qubo(Q',c,d);

end

