function aprox = encontrarGlucosa (x,y,glucosa_meta);
  aprox = [];
  n = length(x); % La lingitud del vector x nos da el numero de coeficientes y terminos para el polinomio interpolante de newton.
  a(1) = y(1); %Aqui esta encontrando el primer coeficiente del polinomio.
  for i=1:n-1;
    divDIF(i,1) = (y(i+1)-y(i))/(x(i+1)-x(i));
  endfor
  %de la linea 7 a la 9 se trabaja la primera diferencia divididas
  for j=2:n-1;
    for i=1: n-j;
      divDIF(i,j) = (divDIF(i+1,j-1)-divDIF(i,j-1))/(x(j+i)-x(i));
    endfor
    endfor
    %De la linea 12 a la 16 se calculan las diferencias dividdidas de orden superior
    for j=2:n;
    a(j) = divDIF(1,j-1); % Aqui se asignan las diferencias divididas a los coeficientes restantes
    endfor

  xtotal = [];
  x = 1;
  for j=1:length(x)-1
    Xint = x(j):0.05:x(j+1);
    xtotal = [xtotal,Xint];
    len = length(Xint); %Se obtiene el tama�o del vector para saber donde finalizar el ciclo
    for i=1:len;
      Yinter(i) = a(1); 
      xn =1;
      for k=2:n;
        xn = xn*(Xint(i)-x(k-1));
        Yinter(i) = Yinter(i) + a(k)*xn; %Se utiliza un vector para alamecnar todas las imagenes
      endfor
    endfor
    Yinter
    for m=1: length(Yinter)
      if glucosa_meta >= (Yinter(m)-2) && glucosa_meta <= (Yinter(m)+2);
        aprox(x) = Xint(m)
        x = x+1;
      endif
    endfor
  endfor
endfunction

