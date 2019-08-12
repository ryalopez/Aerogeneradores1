function [tsc,ts] = AgregarDatosAnuales(tsc,ts)
%AgregarDatosAnuales Summary of this function goes here
%   Detailed explanation goes here
 disp(strcat( 't observatorio: ',num2str(tsc.TimeInfo.StartDate), ...
     ' año: ', num2str(ts.TimeInfo.StartDate)));
 save ('matlab.mat');
 for i=1:min(length(tsc),length(ts))
     if length(find(ts.time(i)==tsc.time(i))) == 0
         % fecha en serie ts no está en la colección tsc
     else
         % fecha en serie ts SI está en la colección tsc
         % no hay que hacer nada
         rafa=1;
     end
 end
  %HsObservatorio = addts(HsObservatorio,HsAnual);
end

