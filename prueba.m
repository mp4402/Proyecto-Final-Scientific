pkg load io

%leer fechas
excelDates = xlsread('datos.xlsx','B1:B138');
matlabDates = 693960 + excelDates;
for i=1: length(matlabDates)
  datestr(matlabDates(i),2)
endfor

%leer horas
pkg load io
excelDates = xlsread('datos.xlsx','D1:D138');
for i=1:length(excelDates)
datestr(excelDates(i),'HH:MM')
endfor
