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
            tabla(:,1)=[];   % borrar columna año
            tabla(:,2)=[];     % borrar columna mes
            tabla(:,3)=[];     % borrar columna día
            tabla(:,4)=[];     % borrar columna hora
            if observatorio ~= "SOUTH SANTA ROSA"
                tabla(:,5)=[];     % borrar columna minuto
                t=table2array(tabla(:,1:7));
                [R, P] = corr(t);
                R=array2table(R,'VariableNames',cabeceras(6:12));
                P=array2table(P,'VariableNames',cabeceras(6:12));
            else
                t=table2array(tabla(:,2:8));
                [R, P] = corr(t);
                R=array2table(R,'VariableNames',cabeceras(5:11));
                P=array2table(P,'VariableNames',cabeceras(5:11));
            end
                
       
        writetable(R,strcat(observatorio,'\Correlaciones.xlsx'),'Sheet','Coeficientes');
        writetable(P,strcat(observatorio,'\Correlaciones.xlsx'),'Sheet','Confianza');       
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

