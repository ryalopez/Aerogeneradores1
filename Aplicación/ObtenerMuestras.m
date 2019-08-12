function [Hs,DirOla,VelViento, DirViento]=ObteberMuestras(datos,observatorio,anno)


%disp(strcat('Datos leidos.- valores NaN: ', string(sum(isnan(datos(:,:))))));
datos(:,:)=fillmissing(datos(:,:),'movmean',[1000 1000]);
%disp(strcat('Datos leidos.- valores NaN: ', string(sum(isnan(datos(:,:))))));

Hs = timeseries(datos(:,2), datos(:,1));
Hs.timeinfo.Units='hours';
Hs.timeinfo.StartDate=Hs.Time(1);
Hs.datainfo.Units='m';
Hs.TreatNaNasMissing=true;

DirOla = timeseries(datos(:,3), datos(:,1), 'name', 'Dirección de las Olas');
DirOla.timeinfo.Units='hours';
DirOla.datainfo.Units='º';
DirOla.TreatNaNasMissing=true;

VelViento =timeseries(datos(:,4), datos(:,1),'name', 'Velocidad viento');
VelViento.timeinfo.Units='hours';
VelViento.datainfo.Units='m/s';
VelViento.TreatNaNasMissing=true;

DirViento =timeseries(datos(:,5), datos(:,1),'name', 'Dirección viento');
DirViento.timeinfo.Units='hours';
DirViento.datainfo.Units='º';
DirViento.TreatNaNasMissing=true;
% ordenar en orden ascendente de tiempo
%Hs=sortrows(Hs);

save('Matlab.mat');

end

