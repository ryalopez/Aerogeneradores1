function [outputArg1,outputArg2] = Pintar()
%PINTAR Summary of this function goes here
%   Detailed explanation goes here
outputArg1 = 0;
outputArg2 = 0;
FicheroExcel = "I:\_____Publicaciones y Tesis\Aerogeneradores\Modelo Datos\Aplicación\Datos\Datos NOAA Buoy Data\NE BAHAMAS\Correlaciones.xlsx";
T = readtable(FicheroExcel,'Sheet','Observaciones','ReadRowNames',false);
%Test the null hypothesis that the data comes from a normal distribution with a mean of 75 and a standard deviation of 10. Use these parameters to center and scale each element of the data vector, because kstest tests for a standard normal distribution by default.

c=table2array(T(:,"WSPD"));
media = mean(c);
desv = std(c);
x = (c-media)/desv;
h = kstest(x)

c=table2array(T(:,"WVHT"));
media = mean(c);
desv = std(c);
y = (c-media)/desv;
h = kstest(y)

%Plot the empirical cdf and the standard normal cdf for a visual comparison.

subplot(1,2,1)
cdfplot(x)
hold on
x_values = linspace(min(x),max(x));
plot(x_values,normcdf(x_values,0,1),'r-')
title('NE BAHAMAS.- Función de distribución acumulada Vel. viento');
legend('CDF Empirica','CDF Distribución Normal','Location','best')

subplot(1,2,2)
cdfplot(y)
hold on
y_values = linspace(min(y),max(y));
plot(y_values,normcdf(y_values,0,1),'r-')
title('NE BAHAMAS.- Función de distribución acumulada H_s oleaje');
legend('CDF Empirica','CDF Distribución Normal','Location','best')

end

