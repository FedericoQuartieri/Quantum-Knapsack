s = [1 1 2 3];
t = [2 4 3 4];
weights = [1 1 1 1];
G = graph(s,t,weights);
%plot(G)


gates = [hGate(1); cxGate(1,2)];
c = quantumCircuit(gates);
plot(c)



x = double(dec2bin(0:15)=='1');
[i,j] = findedge(G);
allFval = sum(x(:,i) .* (1-x(:,j)),2) + sum(x(:,j) .* (1-x(:,i)),2);
allSols = array2table([x,allFval],VariableNames=["x1","x2","x3","x4","f"]);
allSols = sortrows(allSols,"f","descend")

%%%------------- qubo----------------

%qprob = maxcut2qubo(G);
%result = solve(qprob,Algorithm=qaoa)

%result.BestFunctionValue

%result.BestX

%%%-------------------------------------


gamma = 1;
beta = 3;
circuit = qaoaCircuit(G,[gamma;beta],1);
plot(circuit)

numLayers = 2;
numShots = 1000;
objFcn = @(theta) -expectedObjectiveValue(theta,G,numLayers,numShots);
bound = repmat(pi,2*numLayers,1);
%bound is a column vector of 2*numLayers elements with pi in each element
x0Theta = rand(2,numLayers);
options = optimoptions("surrogateopt",InitialPoints=x0Theta,MaxFunctionEvaluations=100);
[angles,bestfval] = surrogateopt(objFcn,-bound,bound,[],[],[],[],[],options)


optimizedCircuit = qaoaCircuit(G,angles,numLayers);
plot(circuit)
sv = simulate(optimizedCircuit);
%histogram(sv)




%reg = "us-east-1";
%bucketPath = "s3://amazon-braket-mathworks/doc-examples";
%device = quantum.backend.QuantumDeviceAWS("Aria 1",S3Path=bucketPath,Region=reg)


%task = run(optimizedCircuit,device,NumShots=1000);
%wait(task)

%results = fetchOutput(task);
%histogram(results)


