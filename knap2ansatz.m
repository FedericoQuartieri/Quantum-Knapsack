function optimizedCircuit = knap2ansatz(weights, values, P, maxW)

display "Ansatz Knapsack"

%computing qubo matrixes
Q = -P * (weights' * weights);
c = values + 2*P*maxW*weights;
d = P*maxW*maxW;

[h, J, constant] = qubo_to_ising(Q + diag(c)); %computing h,J for ising model from qubo formulation

N = length(values);

numLayers = 2;
numShots = 1000;
objFcn = @(theta) -expectedObjectiveValue(N, h, J, values, weights, P, maxW, theta, numLayers,numShots); %function to maximize
bound = repmat(pi,2*numLayers,1); %bound is a column vector of 2*numLayers elements with pi in each element
x0Theta = pi*ones(2,numLayers); % initial guess for angles


figure(1)
plot(qaoaCircuit(N,h,J,x0Theta,numLayers)) %show circuits with all gates and with initial angles 

options = optimoptions("surrogateopt",InitialPoints=x0Theta,MaxFunctionEvaluations=100);
[angles,bestfval] = surrogateopt(objFcn,-bound,bound,[],[],[],[],[],options); %compute best angles

optimizedCircuit = qaoaCircuit(N,h,J,angles,numLayers);
end
