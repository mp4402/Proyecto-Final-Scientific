function aprox = encontrarGlucosa (x,y,glucosa_meta);
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
intersectos = [];
aprox = [];
repetidos = [];
for m=1: length(x)-1;
    %si el siguiente numero es mayor al actual. el minimo va a ser el actual y el maximo el siguiente
    if(x(m+1)> x(m))
       Xint = x(m):0.05:x(m+1);
    else
    %si el siguiente numero es menor al actual, el minimo va a ser el siguiente y el maximo va a ser el actual 
    %se hace un flip
       Xint = flip(x(m+1):0.05:x(m)); 
    endif
    Yinter = [];
    len = length(Xint); 
    for i=1:len;
      Yinter(i) = a(1); 
      xn =1;
      for k=2:n;
        xn = xn*(Xint(i)-x(k-1));
        Yinter(i) = Yinter(i) + a(k)*xn; 
      endfor
    endfor
    menores = find(Yinter <= (glucosa_meta+2)); 
    mayores = find(Yinter >= (glucosa_meta-2)); 
    intersectos = intersect(menores,mayores);
    if length(intersectos)>0;
      for t=1:length(intersectos);
          aprox = [aprox,Xint(intersectos(t))];
      endfor
    endif
    %fprintf("Iteracion %0.0f\n",m)
    %Xint
    %Yinter
endfor

imagen_aprox = [];
for i=1: length(aprox)
  aprox(i) = str2num(sprintf('%0.4f',aprox(i)));
endfor
for i=1: length(aprox)
  imagen_aprox(i) = str2num(sprintf('%0.4f',aprox(i)));
endfor

indice_N = [];
for i=1: length(imagen_aprox)
  indice_N = find(aprox == imagen_aprox(i));
  if length(indice_N) >1
    if length(indice_N) == 2
      aprox(indice_N(2)) = [];
    else
      for k = 2: length(indice_N)-1
        aprox(indice_N(k)) = [];
      endfor
    endif
  endif
endfor


aprox
endfunction