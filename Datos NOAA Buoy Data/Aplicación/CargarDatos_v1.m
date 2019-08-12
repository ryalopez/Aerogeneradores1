%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Lee datos de NOAA orientado a intervalos anuales (cada fichero .txt)   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

clear;
  
ficheros = struct2table(dir());
l=height(ficheros);
for i=1:l
    if ficheros.isdir(i)
        if i > 2
            if mod(i,2)==1
                % Lee el arbol de directorios
                [Hs, DirOlas, VelViento, DirViento] = LeerDirectorio(char(ficheros.name(i)));
            else
                [Hs, DirOlas, VelViento, DirViento] = LeerDirectorio(char(ficheros.name(i)));
            end
        end
        if i == 3
            break;
        end
    end
end

rafa=0;
if rafa==1
%%
%% entrenamiento
%% a partir de información del sobre el viento obtenemos Hs y dirección olas
%%
RedEntrenada = EntrenarRed(Hs,DirOla,VelViento,DirViento,HsV,DirOlaV,VelVientoV,DirVientoV);
end