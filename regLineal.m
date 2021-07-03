function puntos=regLineal(x,y);
  n=length(x);
  x=x(:); y=y(:);
  sx=sum(x); sy=sum(y); %suma de las columnas de "x" y de "y"
  sx2=sum(x.*x); sxy=sum(x.*y); sy2=sum(y.*y);
  puntos(1)=(n*sxy-sx*sy)/(n*sx2-sx^2);
  puntos(2)=sy/n-puntos(1)*sx/n;
  puntos(3)=((n*sxy-sx*sy)/sqrt(n*sx2-sx^2)/sqrt(n*sy2-sy^2))^2;
  xp=linspace(min(x),max(x),2);
  yp=puntos(1)*xp+puntos(2);
  plot(x,y,'*',xp,yp);
  grid on;
endfunction