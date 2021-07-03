function dx = primeraDerivada(x,y)
  %calcula la derivada de una funcion dada por un conjunto de puntos.
  %Se utilizara la derivacion numerica por diferencias finitas.
  % x es un vector que almacena las coordenadas x de los puntos
  % y es un vector que almacena las coordenadas y de los puntos 
  % La variable de salida es un vector dx
  n = length(x);
  dx(1) = (y(2) - y(1))/(x(2)-x(1)); %diferencia finita hacia adelante
  for i=2: n-1;
    dx(i) = (y(i+1)-y(i-1))/(x(i+1)-x(i-1)); %diferencia finita centrada
  endfor
  dx(n) = (y(n)-y(n-1))/(x(n)-x(n-1)); %Diferencia finita hacia atras
 endfunction
