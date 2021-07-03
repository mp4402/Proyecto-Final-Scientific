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

%______ Pregunta: Primera dosis de mediacemento ________________
hora_mediacamento = inputdlg ("Ingrese la hora en la que tom� su primera dosis de medicamento (HH:MM)");
hora_mediacamento = hora_mediacamento{1,1};
tiempo = strsplit(hora_mediacamento,":");
horas = str2double(tiempo{1,1});
minutos = str2double(tiempo{1,2})/60;
hora_mediacamento = (horas+minutos)/24;
%__________________   Fin Pregunta    __________________________

%_______ C�lculo numero de horas (hora glocosa menos toma de medicamento) ________________
tiempo =[];
temporal = 0.00;
for i=1: length(excelhoras);
  temporal = (exhoras(i) - hora_mediacamento);
  if temporal <0;
  temporal2 = datestr(exhoras(i),'HH:MM');
  temporal2 = strsplit(temporal2,":");
  h2 = str2num(temporal2{1,1});
  m2 = str2num(temporal2{1,2});
  
  temporal = datestr(hora_mediacamento,'HH:MM');
  temporal = strsplit(temporal,":");
  h = str2num(temporal{1,1});
  m = str2num(temporal{1,2});
  
  h = h2-h;
  m = (m2-m)/60; 
  if m >0;
    m = m*-1;
  endif
  temporal = h+m;
  tiempo(i) = temporal;
  else
  temporal = datestr(temporal,'HH:MM');
  temporal = strsplit(temporal,":");
  h = str2num(temporal{1,1});
  m = str2num(temporal{1,2})/60;
  temporal = h + m;
  tiempo(i) = temporal;
  endif
endfor
%________________________________ Fin C�lculo ____________________________________________



%____________________ Pregunta: Rango de analisis __________________________________________________
fecha_inicio = inputdlg ("Ingrese fecha de inicio (mm/dd/yy): ");
fecha_inicio = datenum(fecha_inicio{1,1}, "mm/dd/yy");
while(fecha_inicio < matlabDates(1));
  fecha_inicio = inputdlg ("Ingrese otra vez la fecha de inicio (mm/dd/yy): ");
  fecha_inicio = datenum(fecha_inicio{1,1}, "mm/dd/yy");
endwhile
fecha_final = inputdlg ("Ingrese fecha final (mm/dd/yy): ");
fecha_final = datenum(fecha_final{1,1}, "mm/dd/yy");
while(fecha_final>matlabDates(length(matlabDates)));
  fecha_final = inputdlg ("Ingrese otra vez la fecha final (mm/dd/yy): ");
  fecha_final = datenum(fecha_final{1,1}, "mm/dd/yy");
endwhile
      
x = 1;
indices=[];
for i=1:length(excelDates);
   if matlabDates(i) >= fecha_inicio && matlabDates(i) <= fecha_final;
     indices(x) = i;
     x = x+1;
   endif
 endfor
 random = indices;
 
 if length(indices) > 10;
    random = [indices(1): 1: indices(x-1)];
    random = random(randperm (10,10));
 endif
%__________________________ Fin Pregunta ____________________________________________________________

%__________________________ Menu de opciones _________________________________________________________
choice = menu('Seleccione una opcion: ','Gr�ficas','Tabla de metabolizaci�n de glucosa','Aceleraci�n metab�lica de glucosa','Glucosa Promedio','Glucosa-Meta','Tendencia','Resumen Estadistico','Salir');
randomSort=sort(random);
tiempoSort=[];
glucosaSort=[];
for i=1:length(randomSort);
  tiempoSort(i)=tiempo(randomSort(i));
  glucosaSort(i)=excelglucosa(randomSort(i),1);
endfor
switch choice
  case 1  
    %Funcion graficas
    choice2 = menu('Elecci�n de graficas','Puntos','Polinomio')
    switch choice2
      case 1
        %Grafica por puntos
      case 2
        %Grafica por polinomio
      case 3
         otherwise
    endswitch
  case 2
    %Tabla de metabolizacion de glucos
  case 3
    %Aceleracion metabolica
    acelMeta=segundaDerivada(tiempoSort,glucosaSort);
    maxAcelMeta=max(acelMeta);
    minAcelMeta=min(acelMeta);
  case 4
    promGluco=(1/(max(tiempoSort)-min(tiempoSort)))*integral(tiempoSort,glucosaSort)
    %Glucosa Promedio
  case 5
    %Glucosa-Meta
  case 6
    clf
    puntos=regLineal(tiempoSort,glucosaSort); 
    fprintf('La ecuaci�n es: y=%4.5f*x+%4.5f\nEl r2 es: %4.5f\n',puntos(1),puntos(2),puntos(3));    
    %Tendencia
  case 7
    %Resumen Estadistico
    # MEDIA DEL RANGO DE FECHAS
    MEDIA = mean(excelglucosa)
    MEDIANA = median(excelglucosa)
    MODA = mode(excelglucosa)
    VMAX = max(excelglucosa)
    VMIN = min(excelglucosa)
    DESVI = std(excelglucosa)
  case 8
  
  otherwise

endswitch
%__________________________ Fin menu de opciones ________________________________________________________