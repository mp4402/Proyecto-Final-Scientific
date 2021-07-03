%Se utilizará el método del trapecio con intervalos irregulares
function I=integral(x,y);
  n=length(x);
  suma=0;
  for i=1:n-1;
    suma=suma+(y(i)+y(i+1))*(x(i+1)-x(i));
  endfor
  I=0.5*suma;
endfunction