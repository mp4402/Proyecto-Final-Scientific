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
hora_mediacamento = inputdlg ("Ingrese la hora en la que tomó su primera dosis de medicamento (HH:MM)");
hora_mediacamento = hora_mediacamento{1,1};
tiempo = strsplit(hora_mediacamento,":");
horas = str2double(tiempo{1,1});
minutos = str2double(tiempo{1,2})/60;
hora_mediacamento = (horas+minutos)/24;
%__________________   Fin Pregunta    __________________________

%_______ Cálculo numero de horas (hora glocosa menos toma de medicamento) ________________
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
    m = m*-1
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
tiempo
%________________________________ Fin Cálculo ____________________________________________



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


choice = menu('Seleccione una opcion: ','Ingreso de rango de fechas','Salir');
switch choice
  case 1
  case 2
      otherwise
endswitch


 
 
 
 
 
 
