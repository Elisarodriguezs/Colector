clc,
close all
clear all

prefijo1 = 'tubosh';
prefijo2 = 'paredesh';

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

%codigo para distribuir tubos dentro de la cavidad
ax = pared(1,4)/2; %ancho en la direccion x
ay = pared(1,5); %largo en la direccion y
rad = .05; %Radio de los tubos en metros
numt = 300; %numero de tubos
nx = 2*ax/(3*rad/2); %ancho en la direccion x entre (1rad + 0.5rad)
nx = nx-mod(nx,1);  %Hacer del valor anterior un entero 
ny = ay/(3*rad/2);  %ancho en la direccion y entre (1rad + 0.5rad)
ny = ny-mod(ny,1); %Hacer del valor anterior un entero 
nx1 = nx/2; 
if mod(nx1,1)~= 0
    nx1 = (nx1+1)-mod(nx1,1);
end
%posiciones tubos

for i2 = 1:1  %numero de veces que se repetira el proceso
[hisf3 cf3] = hist([-ax:ax],nx); %coordenadas del centro de cada posicion en x
[hisf4 cf4] = hist([0:ay],ny);  %coordenadas del centro de cada posicion en y
tubs = [randi([nx1 nx],1,numt/2); randi([1 ny],1,numt/2)]; %posicion de cada tubo en el "tablero", el primer renglon corresponde a la posicion en x, el segundo en y
ct3_1 = [cf3(tubs(1,:)); cf4(tubs(2,:))]'; %coordenadas del centro de cada tubo
ct3_2 = [-ct3_1(:,1) ct3_1(:,2)]; %segunda mitad de las coordenadas del centro de cada tubo, se coloca en forma de espejo en la segunda mitad del tablero
ct3_2(ct3_2(:,1)==0,:)=[]; %si hay un tubo colocado en el centro, se elimina
ct3 = [ct3_2; ct3_1]; %se juntan las dos mitades de tubos del tablero
ct = [ct3 repmat(rad,size(ct3,1),1)]; %se agrega una tercer columna, el radio del tubo
N = [N;zeros(size(ct,1),3)]; %se agregan una posicion en la matriz N para cada tubo 
 %se agrega un valor "normal" a los tubos (este valor se calcula en reflejado)

 %revisar que rayos entran a la cavidad
A1 = size(A,1);  %tamanio del vector A (# heliostatos en el campo)
c1 = size(rayr,1)/A1; %numero de rayos por heliostatos
c = c1*A1; %numero de rayos que llegan de los heliostatos
%revisamos que el rayo entre a la cavidad, utiizamos la pared 6, rotada
%hacia los heliostatos
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

con_p = zeros(1,((size(pared,1)-1)+size(ct,1))); %8 entradas, 1 para cada pared y 1 para cada tubo
conerr = 0;
c2 = size(Pp_1,1);
P_a = zeros(c2,4);
for b=1:c2 %revisamos todos los rayos
        P_e = Pp_1(b,:);
        rayo = rayo1(b,:);
        p_i = 6;
        absv = false(1); %false(1)=0
        while (absv==0)   
            [p_i,di, N, conerr] = cualpared12_2(rayo, p_i, P_e, pared, N, ct, conerr);  %revisamos en que pared intersecta el rayo
            if p_i==7 || rand < 0.6
                con_p(p_i) = con_p(p_i)+1;
                P_a(b,:) = [P_e + di * rayo, p_i];
                absv = true(1);
            else
            [rayo, P_e] = reflejado12_2(rayo, N(p_i+1,:), P_e, di); %si el rayo no fue absorbido, se refleja
          
            end
        end
end
 
%el siguiente contador sirve para verificar que todos los rayos que entran
%a la cavidad son absorbidos por alguna de las 6 paredes, el resultado debe
%ser cero.
cont = c2-sum(con_p);
con_p1 = con_p(1,7:size(con_p,2));

con_p2 = [];
for c3 = 1:(size(con_p,2)-6);
    con_p3 = repmat(ct(c3,1:2),con_p1(1,c3),1);
    con_p2 = [con_p2; con_p3];
end

[hisf2, cf2] = hist3(con_p2, 'Edges', {(-5: 10/133 : 5),(0 : 10/133 : 10)});


vv = [[2 3]; [1 3]; [2 3]; [1 2]; [1 2]; [1 3]];
vf = [1 ; 2 ; 1 ; 3 ; 3 ; 2];
int = 10/133;
for j = 1:6 %size(pared,1)
    pf = P_a((P_a(:,4) == j),1:3);
    pf1 = pf(:,[vv(j,1) vv(j,2)]);
    [hisf, cf] = hist3(pf1, 'Edges', {(pared(j+1,vv(j,1))-pared(j+1,5)/2 : int : (pared(j+1,vv(j,1))+pared(j+1,5)/2)-int),((pared(j+1,vv(j,2))-pared(j+1,4)/2 : int : (pared(j+1,vv(j,2))+pared(j+1,4)/2)-int))});
    hisf = hisf';
end

%archivos que guardan informacion de numero de impactos y posicion
archivo1 = sprintf('%s%02d.xlsx', prefijo1, i2);
archivo2 = sprintf('%s%02d.xlsx', prefijo2, i2);
xlswrite(archivo1, hisf2)
xlswrite(archivo2, hisf)
end

for ii = 1:i2 %se suman todos los datos de los archivos anteriores
    filename1 = sprintf('%s%02d.xlsx', prefijo1, ii);
    fid(:,:,ii) = xlsread(filename1); 
end

tubtot = sum(fid(:,:,:),3);

%graficas
figure,
z3 = bar3(tubtot);
colorbar

for k = 1:100
    zdata = get(z3(k),'ZData');
    set(z3(k),'CData',zdata,...
             'FaceColor','interp')
end