%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Lee datos de NOAA orientado a intervalos anuales (cada fichero .txt)   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

clear;

DirectorioDatos = "Aplicaci�n\Datos\Datos NOAA Buoy Data";
ficheros = struct2table(dir(DirectorioDatos));
l=height(ficheros);
for i=1:l    
    if ficheros.isdir(i)
        if i > 2
            % Lee el arbol de directorios            
            LeerDirectorio(DirectorioDatos, char(ficheros.name(i)));
        end
    end
end

rafa=0;
if rafa==1
%%
%% entrenamiento
%% a partir de informaci�n del sobre el viento obtenemos Hs y direcci�n olas
%%
RedEntrenada = EntrenarRed(Hs,DirOla,VelViento,DirViento,HsV,DirOlaV,VelVientoV,DirVientoV);
end