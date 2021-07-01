pkg load io
%leer fechas
excelDates = xlsread('datos.xlsx','B1:B138');
nanElements = isnan(excelDates); %indices donde estan los valores NaN
excelDates(nanElements) = []; %eliminar las casillas
matlabDates = 693960 + excelDates;
for i=1: length(matlabDates)
  datestr(matlabDates(i),2)
endfor
%leer horas
excelhoras = xlsread('datos.xlsx','D1:D138');
nanElements = isnan(excelhoras);
excelhoras(nanElements) = [];
for i=1:length(excelhoras)
datestr(excelhoras(i),'HH:MM')
endfor
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