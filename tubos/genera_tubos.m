function [ct] = genera_tubos(pared, numt, rad)
% GENERA_TUBOS genera tubos de forma aleatoria
%
% Genera numt tubos de radio rad de forma aleatoria, conociendo 
% las dimensiones del cubo dadas por pared

%codigo para distribuir tubos dentro de la cavidad
ax = pared(1,4)/2; %ancho en la direccion x
ay = pared(1,5); %largo en la direccion y
%rad = .05; %Radio de los tubos en metros
%numt = 300; %numero de tubos
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
    [~, cf3] = hist((-ax:ax),nx); %coordenadas del centro de cada posicion en x
    [~, cf4] = hist((0:ay),ny);  %coordenadas del centro de cada posicion en y
    tubs = [randi([nx1 nx],1,numt/2); randi([1 ny],1,numt/2)]; %posicion de cada tubo en el "tablero", el primer renglon corresponde a la posicion en x, el segundo en y
    ct3_1 = [cf3(tubs(1,:)); cf4(tubs(2,:))]'; %coordenadas del centro de cada tubo
    ct3_2 = [-ct3_1(:,1) ct3_1(:,2)]; %segunda mitad de las coordenadas del centro de cada tubo, se coloca en forma de espejo en la segunda mitad del tablero
    ct3_2(ct3_2(:,1)==0,:)=[]; %si hay un tubo colocado en el centro, se elimina
    ct3 = [ct3_2; ct3_1]; %se juntan las dos mitades de tubos del tablero
    ct = [ct3 repmat(rad,size(ct3,1),1)]; %se agrega una tercer columna, el radio del tubo
end
