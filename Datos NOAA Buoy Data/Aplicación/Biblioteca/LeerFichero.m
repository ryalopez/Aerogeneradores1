function [Hs, DirOlas, VelViento, DirViento] = LeerFichero(observatorio, fichero)
%LeerDirectorio Lee un fichero *.txt
%   Lee las observaciones de un año y genera una serie temporal para las
%   olas y otra para el viento

    datos = [];

    nfichero=strcat( observatorio, '\', fichero);
    iAnno = strfind(nfichero,'.txt');
    anno = nfichero(iAnno-4:length(nfichero)-4);
    disp(nfichero);

    % YYYY MM DD hh mm  WD  WSPD GST  WVHT  DPD   APD  MWD  BAR    ATMP  WTMP  DEWP  VIS  TIDE
    formatSpec = '%d %d %d %d %d %d %f %f %f %f %f %d %f %f %f %f %f %f\n';
    sizeA = [1 Inf];

    fileID = fopen(nfichero,'r');
    while ~feof(fileID)
        linea = fgetl(fileID);
        [A, count] = sscanf(linea, formatSpec, sizeA);
        if count > 0
            % tiempo
            %%t = datenum([A(1,1),A(1,2),A(1,3),A(1,4),A(1,5),0]);
            t = datenum([0,A(1,2),A(1,3),A(1,4),A(1,5),0]);
            if A(1,9) < 99 && A(1,12) < 999 && A(1,7) < 99 && A(1,6) < 999
                % datos válidos
                % olas tiempo.- tolas(i,1)=A(1,1). Hs.- tolas(i,2)=A(1,9).
                % Dirección.- tolas(i,2)=A(1,12).
                % viento tiempo.- tviento(i,1)=A(1,1). Velocidad.- tviento(i,2)=A(1,7).
                % viento Dirección.- tviento(i,3)=A(1,6);
                datos = [datos;[t,A(1,9), A(1,12), A(1,7), A(1,6)]];  
            else
                 datos = [datos;[t,NaN,NaN,NaN,NaN]];
            end
        end
    end
    fclose(fileID);
    [Hs, DirOlas, VelViento, DirViento]=ObtenerMuestras(datos,observatorio,anno);
    Hs.name=strcat(observatorio,'.- ', anno, '. Hs')
    
end

