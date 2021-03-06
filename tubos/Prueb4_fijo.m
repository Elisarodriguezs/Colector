clc,
close all
clear all

prefijo1 = 'tubosh';
prefijo2 = 'paredesh';

%% Inicializa los datos de los rayos que entran
load datos_ini.mat


%% Genera la información de los tubos y se agrega a N
rad = .05; %Radio de los tubos en metros
numt = 300; %numero de tubos
ct = genera_tubos(pared, numt, rad); 
Nt = [N; zeros(size(ct,1),3)]; %se agregan una posicion en la matriz N para cada tubo  

[con_p, P_a] = simulador_rayos(pared, Nt, Pp_1, rayo1, ct );

%% Extrae información útil


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

%% Guarda información

%archivos que guardan informacion de numero de impactos y posicion
archivo1 = sprintf('%s%02d.xlsx', prefijo1, i2);
archivo2 = sprintf('%s%02d.xlsx', prefijo2, i2);
xlswrite(archivo1, hisf2)
xlswrite(archivo2, hisf)


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