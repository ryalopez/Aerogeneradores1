clear;
clc;
%load('I:\Modelos Simulink\Modelos Simscape\prjEstadosDeLaMar\OlasEntrada.mat');
%load('I:\Modelos Simulink\Modelos Simscape\prjEstadosDeLaMar\OlasSalida.mat');
indices=1:2000;
k=[];
k(1,:) = getdatasamples(OlasEntrada,indices);
k1=[];
k1(1,:) = getdatasamples(OlasSalida,indices);

numFeatures = 1;
numResponses = 1;
numHiddenUnits = 200;

layers = [ ...
    sequenceInputLayer(numFeatures)
    lstmLayer(numHiddenUnits)
    fullyConnectedLayer(numResponses)
    regressionLayer];
options = trainingOptions('adam', ...
    'MaxEpochs',500, ...
    'GradientThreshold',1, ...
    'InitialLearnRate',0.005, ...
    'LearnRateSchedule','piecewise', ...
    'LearnRateDropPeriod',125, ...
    'LearnRateDropFactor',0.2, ...
    'Verbose',0, ...
    'Plots','training-progress');
miredEntrenada=trainNetwork(k(1,:),k1(1,:),layers,options);
save('miredEntrenada.mat','miredEntrenada');
%miredEntrenada=train(mired,k,k1);
% mired=miredEntrenada;
% %
% for i=1:3000
%     i
%     %[miredAdaptada,salida,error] = adapt(miredEntrenada,k1);
%     miredEntrenada=train(mired,k,k1);
%     mired=miredEntrenada;
% end
% figure;
% plot(k1);
% hold on;
% plot(mired(k));
% 
