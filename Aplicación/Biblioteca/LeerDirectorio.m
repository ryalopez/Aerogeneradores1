function LeerDirectorio(DirectorioDatos, nombre)
%LeerDirectorio Lee todos los ficheros *.txt de directorio
%   Cada fichero *.txt corresponde a un año de observaciones
    observatorio = strcat(DirectorioDatos,'\',nombre);
    ndirectorio=strcat( observatorio, '\*_rawdata.mat');
    ficheros=dir(ndirectorio);
    if length(ficheros) > 0
        disp(observatorio);
        load(strcat( observatorio, '\', ficheros(1).name));
        [t tiempos cabeceras ncolumnas]=ExtraerTabla(data_rem_no0);      
        % poner la cabecera a la tabla de observaciones
        %tabla=tabla(:,1:7);
        tabla=array2table(t,'VariableNames',cabeceras(6:12));
        if ncolumnas == 18
            tabla.Properties.VariableNames = cabeceras(6:12);
        else
            tabla.Properties.VariableNames = cabeceras(5:11);
        end
        writetable(tabla,strcat(observatorio,'\Correlaciones.xlsx'),'Sheet','Observaciones');       
        
        tabla=[tiempos, tabla];
        medidas = table2timetable(tabla,'RowTimes','Tiempo');              
        writetimetable(medidas,strcat(DirectorioDatos,'\Todas.xlsx'),'Sheet',nombre);       
%%        save(strcat(observatorio,'\observaciones.mat'),'observaciones');
%         degreeSymbol = char(176);
%         newYlabels = {'WD (%)','MWD (º)'};
        %s=stackedplot(observaciones,{'WD','MWD'})
        %s.Title='Direcciones viento y olas';
        %s.XLimits=[datetime(2005,6,1,0,0,0)    datetime(2006,12,31,23,0,0)]
        %'DisplayLabels',newYlabels,)
%         stackedplot(observaciones,{'WD','WSPD', 'GST', 'WVHT', 'DPD', 'APD', 'MWD'})
    end
end

