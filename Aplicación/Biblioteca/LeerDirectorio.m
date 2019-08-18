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
        annos = length(data_rem_no0);
        t=[];
        for i=1:annos
            datos=data_rem_no0(i).yeardata;
            cabeceras=data_rem_no0(i).yearvar;
            tabla=array2table(datos,'VariableNames',cabeceras);
            z=size(tabla);
            ncolumnas=z(2);
            if ncolumnas == 18
                tiempos=array2table(datetime(table2array(tabla(:,1)), ...
                    table2array(tabla(:,2)), table2array(tabla(:,3)), ...
                    table2array(tabla(:,4)), ...
                    table2array(tabla(:,5)),0),'VariableNames',{'Tiempo'});
                tabla(:,1:5)=[];   % borrar columna año, mes, día, hora, minuto
            else
                tiempos=array2table(datetime(table2array(tabla(:,1)), ...
                    table2array(tabla(:,2)), table2array(tabla(:,3)), ...
                    table2array(tabla(:,4)), ...
                    0,0),'VariableNames',{'Tiempo'});
                tabla(:,1:4)=[];   % borrar columna año, mes, día, hora, minuto
            end
            t=[t; table2array(tabla(:,1:7))];
        end        
        z = size(t);
        kolmo=[];
        for i = 1:z(2)
            x=t(:,i);
            media = mean(x);
            desv = std(x);
            [h p]=kstest((x-media)/desv);
            kolmo(1,i+1)=h;
            kolmo(2,i+1)=p;
        end
          
        cab = cellstr("Estadisticos");   
        if ncolumnas == 18
            D=table2cell(array2table(kolmo,'VariableNames',[cab(1);cabeceras(6:12)]));
            D(1,1)={"KOLMOGOROV"};
            D(2,1)={"P-VALOR"};
            D=cell2table(D,'VariableNames',[cab(1);cabeceras(6:12)]);
        else
            D=table2cell(array2table(kolmo,'VariableNames',[cab(1);cabeceras(5:11)]));
            D(1,1)={"KOLMOGOROV"};
            D(2,1)={"P-VALOR"};
            D=cell2table(D,'VariableNames',[cab(1);cabeceras(5:11)]);
        end       
        writetable(D,strcat(observatorio,'\Correlaciones.xlsx'),'Sheet','Estadísticos');
        [R, P] = corrcoef(t,'Rows','complete');
        cab = cellstr("vs");
        if ncolumnas == 18
            x=cabeceras(6:12);
            R = [x, table2cell(array2table(R))];
            R=cell2table(R,'VariableNames',[cab(1);cabeceras(6:12)]);
            P = [x, table2cell(array2table(P))];
            P=cell2table(P,'VariableNames',[cab(1);cabeceras(6:12)]);
        else
            x=cabeceras(5:11);
            R = [x, table2cell(array2table(R))];
            R=cell2table(R,'VariableNames',[cab(1);cabeceras(5:11)]);
            P = [x, table2cell(array2table(P))];
            P=cell2table(P,'VariableNames',[cab(1);cabeceras(5:11)]);
        end
        writetable(R,strcat(observatorio,'\Correlaciones.xlsx'),'Sheet','Coeficientes');
        writetable(P,strcat(observatorio,'\Correlaciones.xlsx'),'Sheet','Confianza');
        writetable(tabla(:,1:7),strcat(observatorio,'\Correlaciones.xlsx'),'Sheet','Observaciones');       
        
        tabla=[tiempos, tabla(:,1:7)];
        observaciones = table2timetable(tabla,'RowTimes','Tiempo');              
        save(strcat(observatorio,'\observaciones.mat'),'observaciones');
%         degreeSymbol = char(176);
%         newYlabels = {'WD (%)','MWD (º)'};
        %s=stackedplot(observaciones,{'WD','MWD'})
        %s.Title='Direcciones viento y olas';
        %s.XLimits=[datetime(2005,6,1,0,0,0)    datetime(2006,12,31,23,0,0)]
        %'DisplayLabels',newYlabels,)
%         stackedplot(observaciones,{'WD','WSPD', 'GST', 'WVHT', 'DPD', 'APD', 'MWD'})
    end
end

