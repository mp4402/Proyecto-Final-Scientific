function d2x=segundaDerivada(x,y);
  n=length(x);
  d2x(1)=(y(1)-2*y(2)+y(3))/((x(2)-x(1))^2); %Segunda derivada, dif. finitas hacia adelante
  for i=2:n-1; 
    d2x(i)=(y(i-1)-2*y(i)+y(i+1))/((x(i)-x(i-1))^2);
  endfor
  d2x(n)=(y(n-2)-2*y(n-1)+y(n))/((x(n)-x(n-1))^2);
endfunction