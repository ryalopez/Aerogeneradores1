function y = PintarGraficas(Hs, DirOla, VelViento, DirViento)
% Dibuja gr�ficos de oleaje y viento
%   Detailed explanation goes here

%%
%% gr�ficas oleaje
%%

indices=1:Hs.AlturaDeLasOlas.Length;

% Gr�fico de barras
x=0:10:360;
%olas=getdatasamples(Hs,indices)(:,2);
olas=Hs.AlturaDeLasOlas.data(:,1);
%hisogram horas=hist(olas,x);

imax = find(horas==max(horas));

figure;
hold on;
subplot(2,2,2);
bar(x,horas)
title(strcat('Direcci�n predominante oleaje', num2str(x(imax)) ,'�'));
xlabel('Direcci�n Oleaje(�)')
ylabel('casos')

% Diagrama polar
x1=[x 365];
ang=x1*pi/180;
horas1=[horas horas(1)];
subplot(2,2,4);
gc=polarplot(ang,horas1,'r');
set(gc, 'linewidth',2);
%title(strcat('Direcci�n predominante viento', num2str(x(imax)) ,'�'));


%%
%% gr�ficas viento
%%
% Gr�fico de barras
x=0:10:360;
viento=VelViento.data
%% histogramhoras=hist(viento,x);

imax = find(horas==max(horas)); 

subplot(2,2,1);
bar(x,horas)
title(strcat('Direcci�n predominante viento', num2str(x(imax)) ,'�'));
xlabel('Direcci�n Viento(�)')
ylabel('casos')

% Diagrama polar
x1=[x 365];
ang=x1*pi/180;
horas1=[horas horas(1)];
subplot(2,2,3);
gc=polarplot(ang,horas1,'r');
set(gc, 'linewidth',2);
%title(strcat('Direcci�n predominante viento', num2str(x(imax)) ,'�'));

% Dibuja resultados para un mes (720h)

figure;


subplot(2,1,1);
plot(Hs.AlturaDeLasOlas);
hold on;
plot(VelViento);
%xlim([0,720]);
legend('altura significante (m)','velocidad viento (m/s)');
xlabel('d�a');
title('Medidas de H_s olas y velocidad viento durante un a�o');

subplot(2,1,2);

olas=Hs.AlturaDeLasOlas.data(:,1);
viento=VelViento.data(:,1);

%plot(viento,olas, '+');
plotmatrix(viento,olas,'o');
% con m�s de 20 casos da NaN
casos = 20;
[rho1 pvalor1]= corr(viento(1:casos,1),olas(1:casos,1));
%[rho pvalor]= corrcoef(viento(1:casos,1),olas(1:casos,1))
save matlab.mat
end

