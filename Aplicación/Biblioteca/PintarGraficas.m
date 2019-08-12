function y = PintarGraficas(Hs, DirOla, VelViento, DirViento)
% Dibuja gráficos de oleaje y viento
%   Detailed explanation goes here

%%
%% gráficas oleaje
%%

indices=1:Hs.AlturaDeLasOlas.Length;

% Gráfico de barras
x=0:10:360;
%olas=getdatasamples(Hs,indices)(:,2);
olas=Hs.AlturaDeLasOlas.data(:,1);
%hisogram horas=hist(olas,x);

imax = find(horas==max(horas));

figure;
hold on;
subplot(2,2,2);
bar(x,horas)
title(strcat('Dirección predominante oleaje', num2str(x(imax)) ,'º'));
xlabel('Dirección Oleaje(º)')
ylabel('casos')

% Diagrama polar
x1=[x 365];
ang=x1*pi/180;
horas1=[horas horas(1)];
subplot(2,2,4);
gc=polarplot(ang,horas1,'r');
set(gc, 'linewidth',2);
%title(strcat('Dirección predominante viento', num2str(x(imax)) ,'º'));


%%
%% gráficas viento
%%
% Gráfico de barras
x=0:10:360;
viento=VelViento.data
%% histogramhoras=hist(viento,x);

imax = find(horas==max(horas)); 

subplot(2,2,1);
bar(x,horas)
title(strcat('Dirección predominante viento', num2str(x(imax)) ,'º'));
xlabel('Dirección Viento(º)')
ylabel('casos')

% Diagrama polar
x1=[x 365];
ang=x1*pi/180;
horas1=[horas horas(1)];
subplot(2,2,3);
gc=polarplot(ang,horas1,'r');
set(gc, 'linewidth',2);
%title(strcat('Dirección predominante viento', num2str(x(imax)) ,'º'));

% Dibuja resultados para un mes (720h)

figure;


subplot(2,1,1);
plot(Hs.AlturaDeLasOlas);
hold on;
plot(VelViento);
%xlim([0,720]);
legend('altura significante (m)','velocidad viento (m/s)');
xlabel('día');
title('Medidas de H_s olas y velocidad viento durante un año');

subplot(2,1,2);

olas=Hs.AlturaDeLasOlas.data(:,1);
viento=VelViento.data(:,1);

%plot(viento,olas, '+');
plotmatrix(viento,olas,'o');
% con más de 20 casos da NaN
casos = 20;
[rho1 pvalor1]= corr(viento(1:casos,1),olas(1:casos,1));
%[rho pvalor]= corrcoef(viento(1:casos,1),olas(1:casos,1))
save matlab.mat
end

