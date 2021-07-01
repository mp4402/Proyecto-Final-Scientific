pkg load io
excelDates = xlsread('datos.xlsx','B1:B138');
matlabDates = 693960 + excelDates;
for i=1: length(matlabDates)-1
  datestr(matlabDates(i),2)
endfor
