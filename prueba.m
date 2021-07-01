pkg load io
%leer fechas
excelDates = xlsread('datos.xlsx','B1:B138');
nanElements = isnan(excelDates); %indices donde estan los valores NaN
excelDates(nanElements) = []; %eliminar las casillas
matlabDates = 693960 + excelDates;
excelDates = datestr(matlabDates,2);

%leer horas
excelhoras = xlsread('datos.xlsx','D1:D138');
nanElements = isnan(excelhoras);
excelhoras(nanElements) = [];
exhoras = excelhoras;
excelhoras = datestr(excelhoras,'HH:MM');

%leer mg/dlmread
excelglucosa = xlsread('datos.xlsx','C1:C138');
nanElements = isnan(excelglucosa);
excelglucosa(nanElements) = [];

%leer condicion 
[n, condiciones] = xlsread('datos.xlsx','E3:E138');
printf('\n\n\n\n\n');
%p = condiciones(136,1);
%a=condiciones{136,1};

choice = menu('Seleccione una opcion: ','Ingreso de hora habitual en la que se toma el medicamento','Ingreso de rango de fechas','Salir');
switch choice
  case 1
      hora = input("Ingrese la hora habitual (HH:MM): ", 's')
      tiempo = strsplit(hora,":");
      h = tiempo{1,1};
      m = tiempo{1,2};
      h = str2double(h);
      m = str2double(m)/60;
      hora = h +m;
      hora = hora/24;
      
case 2
    fecha_inicio = datenum(input("Ingrese fecha de inicio (mm/dd/yy): ",'s'),"mm/dd/yy");
    while(fecha_inicio < matlabDates(1));
      fecha_inicio = datenum(input("Ingrese otra vez la fecha de inicio (mm/dd/yy): ",'s'),"mm/dd/yy");
    endwhile  
    fecha_final = datenum(input("Ingrese fecha final (mm/dd/yy): ",'s'),"mm/dd/yy");
    while(fecha_final>matlabDates(length(matlabDates)));
      fecha_final = datenum(input("Ingrese otra vez la fecha final (mm/dd/yy): ",'s'),"mm/dd/yy");
    endwhile
    
    x = 1;
    indices=[];
    for i=1:length(excelDates)
       if fecha_inicio >= matlabDates(i)
         indices(x) = i;
         x = x+1;
       endif
     endfor
     
     if length(indices) > 10
        random = [indices(1): 1: indices(x)]
        random = random(randperm (10,10))
     endif
  case 3
  otherwise
endswitch

 
 
 
 
 
 
