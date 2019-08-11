function [Hs, DirOlas, VelViento, DirViento] = LeerDirectorio(observatorio)
%LeerDirectorio Lee todos los ficheros *.txt de directorio
%   Cada fichero *.txt corresponde a un año de observaciones

    Hs=[];
    DirOlas=[];
    VelViento=[];
    DirViento=[];
    ndirectorio=strcat( observatorio, '\*_rawdata.mat');
    ficheros=dir(ndirectorio);
    if length(ficheros) > 0
        disp(observatorio);
        load(strcat( observatorio, '\', ficheros(1).name));
        datos=data_rem_no0.yeardata;
        cabeceras=data_rem_no0.yearvar;
        tabla=array2table(datos,'VariableNames',cabeceras);
        tiempos=array2table(datetime(table2array(tabla(:,1)), ...
            table2array(tabla(:,2)), table2array(tabla(:,3)), ...
            table2array(tabla(:,4)), ...
            table2array(tabla(:,5)),0),'VariableNames',{'Tiempo'});
        %kike depurar YYYY
            tabla.YYYY=[];   % borrar columna año
            tabla.MM=[];     % borrar columna mes
            tabla.DD=[];     % borrar columna día
            tabla.hh=[];     % borrar columna hora
            tabla.mm=[];     % borrar columna minuto
        t=table2array(tabla(:,1:7));
        [R, P] = corr(t);
        writematrix(R,'CorrelacionesCoeficientes.xlsx','Sheet',observatorio);
        writematrix(P,'CorrelacionesConfianza.xlsx','Sheet',observatorio);
        tabla=[tiempos, tabla];
        observaciones = table2timetable(tabla,'RowTimes','Tiempo');
        save('observaciones.mat','observaciones');
%         degreeSymbol = char(176);
%         newYlabels = {'WD (%)','MWD (º)'};
        %s=stackedplot(observaciones,{'WD','MWD'})
        %s.Title='Direcciones viento y olas';
        %s.XLimits=[datetime(2005,6,1,0,0,0)    datetime(2006,12,31,23,0,0)]
        %'DisplayLabels',newYlabels,)
%         stackedplot(observaciones,{'WD','WSPD', 'GST', 'WVHT', 'DPD', 'APD', 'MWD'})
    end
end

