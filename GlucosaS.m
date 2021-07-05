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
hora_entera_medicamento = horas;
minutos = str2double(tiempo{1,2})/60;
hora_decimal_medicamento = minutos;
hora_mediacamento = (horas+minutos)/24;
hora_total_mediacmento = hora_mediacamento*24;
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

randomSort=sort(random);
tiempoSort=[];
glucosaSort=[];
tiempoSortGrafica = [];
glucosaSortGrafica= [];
for i=1:length(randomSort);
  tiempoSort(i)=tiempo(randomSort(i));
  tiempoSortGrafica(i)=tiempo(randomSort(i));
  glucosaSort(i)=excelglucosa(randomSort(i),1);
  glucosaSortGrafica(i) = excelglucosa(randomSort(i),1);
endfor

for i=1:length(tiempoSort);
  Nindices = find(tiempoSortGrafica == tiempoSort(i));
  if length(Nindices>1)
    for k=2:length(Nindices);
      tiempoSortGrafica(Nindices(k)) = [];
      glucosaSortGrafica(Nindices(k)) = [];
    endfor
  endif
endfor
%tiempoSort
tiempoSortGrafica;
%glucosaSort
glucosaSortGrafica;
while 1;
  choice = menu('Seleccione una opcion: ','Gr�ficas','Tabla de metabolizaci�n de glucosa','Aceleraci�n metab�lica de glucosa','Glucosa Promedio','Glucosa-Meta','Tendencia','Resumen Estadistico','Salir');
  clf
  clc
  switch choice
    case 1  
      %Funcion graficas
      choice2 = menu('Elecci�n de graficas','Puntos','Polinomio')
      switch choice2
        case 1
          %Grafica por puntos
          graficas(tiempoSort,glucosaSort,1);
        case 2
          %Grafica por polinomio
          Yinter = graficas(tiempoSortGrafica,glucosaSortGrafica,2);
          grid on
        case 3
           otherwise
      endswitch
    case 2
      %Tabla de metabolizacion de glucos
      derivada = primeraDerivada(tiempoSortGrafica,glucosaSortGrafica);
      fprintf('   Fecha     Razon de Cambio  Condicion\n');
      for i=1:length(derivada)
        if(derivada(randomSort(i)) < 0)
          if(derivada(randomSort(i))<=-10)
            fprintf('%s     %4.5f        %4s\n',datestr(matlabDates(randomSort(i))),derivada(randomSort(i)),condiciones{randomSort(i),1});
          else
            fprintf('%s     %4.5f         %4s\n',datestr(matlabDates(randomSort(i))),derivada(randomSort(i)),condiciones{randomSort(i),1});
          endif
        else
          if(derivada(randomSort(i))>=10)
            fprintf('%s     +%4.5f        %4s\n',datestr(matlabDates(randomSort(i))),derivada(randomSort(i)),condiciones{randomSort(i),1});
          else
            fprintf('%s     +%4.5f         %4s\n',datestr(matlabDates(randomSort(i))),derivada(randomSort(i)),condiciones{randomSort(i),1});
          endif
        endif
      endfor
      
    case 3
      %Aceleracion metabolica
      acelMeta=segundaDerivada(tiempoSortGrafica,glucosaSortGrafica);
      maxAcelMeta=max(acelMeta);
      minAcelMeta=min(acelMeta);
      fprintf('La aceleraci?n maxima es: %4.5f\nLa aceleraci?n minima es: %4.5f\n\n',maxAcelMeta,minAcelMeta);
    case 4
      promGluco=(1/(max(tiempoSortGrafica)-min(tiempoSortGrafica)))*integral(tiempoSortGrafica,glucosaSortGrafica);
      printf('Glucosa promedio: %4.5f\n',promGluco);
      %Glucosa Promedio
    case 5
      %Glucosa-Meta
      nuevas_horas =[];
      glucosa_meta = inputdlg("Ingrese el nievl del glucosa: ");
      glucosa_meta = str2num(glucosa_meta{1,1});
      horas_aproximadas = encontrarGlucosa(tiempoSortGrafica,glucosaSortGrafica,glucosa_meta);
      for i=1:length(horas_aproximadas);
        if horas_aproximadas(i) > 0
         entera_aprox = floor(horas_aproximadas(i));
         entera_aprox = floor(horas_aproximadas(i)) + floor(hora_entera_medicamento);
         decimal_aprox = horas_aproximadas(i) - floor(horas_aproximadas(i));
         decimal_aprox = (decimal_aprox + hora_decimal_medicamento)*60;
         fprintf('%0.0f:%0.0f\n',entera_aprox,decimal_aprox);
        else
           hora_aprox =  horas_aproximadas(i) + hora_total_mediacmento;
           entera_aprox = floor(hora_aprox);
           decimal_aprox = (hora_aprox - entera_aprox)*60;
           fprintf('%0.0f:%0.0f\n',entera_aprox,decimal_aprox);
        endif
      endfor
    case 6
      clf
      puntos=regLineal(tiempoSort,glucosaSort); 
      fprintf('La ecuaci�n es: y=%4.5f*x+%4.5f\nEl r2 es: %4.5f\n',puntos(1),puntos(2),puntos(3));    
      %Tendencia
    case 7
      %Resumen Estadistico
      # MEDIA DEL RANGO DE FECHAS
      MEDIA = mean(excelglucosa(indices,1))
      MEDIANA = median(excelglucosa(indices,1))
      MODA = mode(excelglucosa(indices,1))
      Glucosa_Maxima = max(excelglucosa(indices,1))
      Glucosa_Minima = min(excelglucosa(indices,1))
      Desviasion_estandar = std(excelglucosa(indices,1))
    case 8
      break
    otherwise

  endswitch
endwhile

%__________________________ Fin menu de opciones ________________________________________________________