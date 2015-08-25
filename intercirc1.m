%interseccion con un tubo
marc=marc+1;

%revisar si el rayo intersecta con el tubo
%Solo trabajaremos en 2D, con el eje X y Y
%encontramos la ecuacion de la recta utilizando las componentes X,Y de
%P_h (punto en el heliostato) y Pp6 (punto en la entrada a la cavidad)

h=0;
k=2.5;
r=0.5;
m = (Pp6(1,2)-P_h(1,2))/(Pp6(1,1)-P_h(1,1));
a1=1+m^2;
b1=2*Pp6(1,2)*m-2*m^2*Pp6(1,1)-2*h-2*m*k;
c1=h^2+k^2-r^2+Pp6(1,2)^2-2*Pp6(1,2)*m*Pp6(1,1)+m^2*Pp6(1,1)^2-2*Pp6(1,2)*k+2*m*Pp6(1,1)*k;
d1=b1^2-4*a1*c1;

if d1>0 | d1==0
   ran1=rand(1,1);
   if ran1<0.8
       absc=absc+1;
          else
            rayr = -(2*(dot(rayr,N2).*N2)-rayr);
        abs2=abs2+1;
    absc=absc+1;
elseif d1=0

