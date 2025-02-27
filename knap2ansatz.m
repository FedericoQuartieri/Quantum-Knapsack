function optimizedCircuit = knap2qubo(weights, values, P, maxW)

display "Ansatz Knapsack"

Q = P * kron(weights', weights);

[h, J, constant] = qubo_to_ising(Q);

N = length(values)

numLayers = N;
numShots = 1000;
objFcn = @(theta) -expectedObjectiveValue(N, h, J, values, theta, numLayers,numShots);
bound = repmat(pi,2*numLayers,1);
%bound is a column vector of 2*numLayers elements with pi in each element
x0Theta = rand(2,numLayers);
options = optimoptions("surrogateopt",InitialPoints=x0Theta,MaxFunctionEvaluations=100);
[angles,bestfval] = surrogateopt(objFcn,-bound,bound,[],[],[],[],[],options)

optimizedCircuit = qaoaCircuit(N,h,J,angles,numLayers);

sv = simulate(optimizedCircuit);
histogram(sv)
