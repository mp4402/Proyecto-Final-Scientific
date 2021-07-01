pkg load io
%leer fechas
excelDates = xlsread('datos.xlsx','B1:B138');
nanElements = isnan(excelDates); %indices donde estan los valores NaN
excelDates(nanElements) = []; %eliminar las casillas
matlabDates = 693960 + excelDates;
excelDates = datestr(matlabDates,2)

%leer horas
excelhoras = xlsread('datos.xlsx','D1:D138');
nanElements = isnan(excelhoras);
excelhoras(nanElements) = [];
excelhoras = datestr(excelhoras,'HH:MM');

%leer mg/dlmread
excelglucosa = xlsread('datos.xlsx','C1:C138');
nanElements = isnan(excelglucosa);
excelglucosa(nanElements) = [];
excelglucosa

%leer condicion 
[n, condiciones] = xlsread('datos.xlsx','E3:E138')
printf('\n\n\n\n\n');
p = condiciones(136,1)
a=condiciones{136,1}

fecha_inicio = datenum(input("Ingrese fecha de inicio (dd/mm/yyyy): ",'s'),"dd/mm/yyyy");
fecha_final = datenum(input("Ingrese fecha final (dd/mm/yyyy): ",'s'),"dd/mm/yyyy");

x = 1;
for i=1: length(excelDates)
     if fecha_inicio >= datenum(excelDates(i),"dd/mm/yyyy") && fecha_final <= datenum(excelDates(i),"dd/mm/yyyy")
       indices(x) = i;
       x = x+1;
     endif
 endfor
 
 if length(indices) > 10
      random = [indices(1): 1: indices(x)]
      random = random(randperm (10,10))
 endif
 
 
 
 
