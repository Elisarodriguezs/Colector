filename1 = 'rayr3.xlsx';
rayr = xlsread(filename1);
filename2 = 'P_h3.xlsx';
P_h = xlsread(filename2);
filename3 = 'posiciones_grande.xlsx';
A = xlsread(filename3);

%pared se especifica el centro de la pared (3coord), alto y ancho, la inclinacion y la
%rotacion
pared = [0.0, 0.0, 60.0, 10.0, 10.0, 4*pi/6, 0;...
         -5.0, 5.0, 60.0, 10.0, 10.0, pi/2, pi/2; ...
         0.0, 10.0, 60.0, 10.0, 10.0, pi/2, 0; ...
         5.0, 5.0, 60.0, 10.0, 10.0, pi/2, -pi/2; ...
         0.0, 5.0, 55.0, 10.0, 10.0, 0, 0; ...
         0.0, 5.0, 65.0, 10.0, 10.0, pi, 0;...
         0.0, 0.0, 60.0, 10.0, 10.0, 3*pi/2, 0];

%se calculan los vectores de direccion s y t, asi como el vector normal  
sp_norm = [-cos(pared(:,6)).*sin(pared(:,7)), cos(pared(:,6)).*cos(pared(:,7)), sin(pared(:,6))];
tp_norm = [cos(pared(:,7)), sin(pared(:,7)), 0*pared(:,7)];
N = cross(tp_norm,sp_norm);


 %revisar que rayos entran a la cavidad
A1 = size(A,1);  %tamanio del vector A (# heliostatos en el campo)
c1 = size(rayr,1)/A1; %numero de rayos por heliostatos
c = c1*A1; %numero de rayos que llegan de los heliostatos

% revisamos que el rayo entre a la cavidad, utiizamos la pared 6, rotada
% (pared(1,:)) hacia los heliostatos
d6_p = dot((ones(c,1)*pared(1, 1:3) - P_h), ones(c,1) * N(1, :), 2) ./ dot(rayr,ones(c,1) * N(1,:), 2); %distancia del heliostato a la pared6 (pared de entrada) en metros
pp = repmat(d6_p,1,3).*rayr; % vector con todas sus componentes igual a d6_p 
Pp_6 = P_h+pp; %puntos en la pared6
tp6_revs = abs(dot((Pp_6-ones(c,1) * pared(1, 1:3)), ones(c,1)*tp_norm(1, :), 2)); %proyeccion del vector Pp6-pared6 en tp6_norm
sp6_revs = abs(dot((Pp_6-ones(c,1) * pared(1, 1:3)), ones(c,1)*sp_norm(1, :), 2)); %proyeccion del vector Pp6-pared6 en sp6_norm
Pp_1 = repmat([0,0,0],c,1);

for b1=1:c %revisamos todos los rayos
    if (tp6_revs(b1,1) <= pared(1, 4)/2) && (sp6_revs(b1,1) <= pared(1, 5)/2) %revisamos que el rayo entre a la cavidad
    Pp_1(b1,:)=Pp_6(b1,:);  
    end
end

rayo1 = rayr;
rayo1(Pp_1(:,3)==0,:)=[]; %Para todos los valores de Pp_1 que conserven el valor para z, se cancelan
Pp_1(Pp_1(:,3)==0,:)=[];

tet = (pi/2)-pared(1,6);  %angulo entre la pared 2(pared vertical) y la pared 1 (inclinada)
Mrx = [1, 0, 0;
       0, cos(tet), -sin(tet);
       0, sin(tet), cos(tet)];  %Matriz de rotacion sobre eje x
   
Pp_1 = [Pp_1(:,1), Pp_1(:,2), Pp_1(:,3)-60]; %restamos a los Pp_1 el vector del centro de la pared
Pp_1 = (Mrx*Pp_1')'; %rotamos los puntos
Pp_1 = [Pp_1(:,1),Pp_1(:,2)==0,Pp_1(:,3)+pared(1,3)]; %hacemos los valores cercanos a y=0
rayo1 = (Mrx*rayo1')'; %rotamos los rayos


save datos_ini.mat pared N Pp_1 rayo1


