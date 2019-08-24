function [t tiempos cabeceras ncolumnas] = ExtraerTabla(DatosMedidos)
%EXTRAERTABLA Summary of this function goes here
%   Detailed explanation goes here
    annos = length(DatosMedidos);
    t=[];
    tiempos=[];
    cabeceras=[];
    ncolumnas=0;
    for i=1:annos
        datos=DatosMedidos(i).yeardata;
        cabeceras=DatosMedidos(i).yearvar;
        tabla=array2table(datos);%,'VariableNames',cabeceras);
        z=size(tabla);
        ncolumnas=z(2);
        if ncolumnas == 18
            tiempos=[tiempos; array2table(datetime(table2array(tabla(:,1)), ...
                table2array(tabla(:,2)), table2array(tabla(:,3)), ...
                table2array(tabla(:,4)), ...
                table2array(tabla(:,5)),0),'VariableNames',{'Tiempo'})];
            tabla(:,1:5)=[];   % borrar columna año, mes, día, hora, minuto
        else
            tiempos=[tiempos; array2table(datetime(table2array(tabla(:,1)), ...
                table2array(tabla(:,2)), table2array(tabla(:,3)), ...
                table2array(tabla(:,4)), ...
                0,0),'VariableNames',{'Tiempo'})];
            tabla(:,1:4)=[];   % borrar columna año, mes, día, hora, minuto
        end
        t=[t; table2array(tabla(:,1:7))];
    end
end

