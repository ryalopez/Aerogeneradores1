function RedEntrenada = EntrenarRed(Hs,DirOla,VelViento,DirViento,HsV,DirOlaV,VelVientoV,DirVientoV)
%%
%% entrenamiento
%% a partir de información del sobre el viento obtenemos Hs y dirección olas
%%
% 2 semanas 1680 horas
indices=1:1680;
k=[];
k(1,:) = getdatasamples(VelViento,indices);
k(2,:) = getdatasamples(DirViento,indices);
k1=[];
k1(1,:) = getdatasamples(Hs,indices);
k1(2,:) = getdatasamples(DirOla,indices);
kv=[];
kv(1,:) = getdatasamples(VelVientoV,indices);
kv(2,:) = getdatasamples(DirVientoV,indices);
k1v=[];
k1v(1,:) = getdatasamples(HsV,indices);
k1v(2,:) = getdatasamples(DirOlaV,indices);

numFeatures = 2;
numResponses = 2;
numHiddenUnits = 300;

layers = [ ...
    sequenceInputLayer(numFeatures)
    lstmLayer(numHiddenUnits)
    fullyConnectedLayer(numResponses)
    regressionLayer];
options = trainingOptions('adam', ...
    'MaxEpochs',250, ...
    'GradientThreshold',1, ...
    'InitialLearnRate',0.005, ...
    'LearnRateSchedule','piecewise', ...
    'LearnRateDropPeriod',125, ...
    'LearnRateDropFactor',0.2, ...
    'Verbose',0, ...
    'Plots','training-progress');
RedEntrenada=trainNetwork(k(1:2,:),k1(1:2,:),layers,options);
save('RedEntrenada.mat','RedEntrenada');
