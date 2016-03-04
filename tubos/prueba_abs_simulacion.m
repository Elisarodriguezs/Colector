clc,
close all
clear all

tiempo = cputime;

prefijo1 = 'tubosh';
prefijo2 = 'paredesh';

%% Inicializa los datos de los rayos que entran
load datos_ini.mat
nt = 300; % numero de tubos
num_config = 100; % numero de configuraciones
contador_abs = zeros(num_config, nt + 6);
configuraciones = zeros(nt, 2 * num_config);

% Para diferentes configuraciones aleatorias
for configuracion = 1:num_config

    % Genera la información de los tubos y se agrega a N
    ct = genera_tubos(pared, nt, 0.05); % nt tubos de radio 0.05 
    Nt = [N; zeros(size(ct,1),3)]; %se agregan una posicion en la matriz N para cada tubo  

    % Se realiza la simulacion
    [con_p, P_a] = simulador_rayos(pared, Nt, Pp_1, rayo1, ct );

    % Se guardan las variables importantes
    contador_abs(configuracion, 1:size(con_p,2)) = con_p;
    ind = 2 * (configuracion -1) + 1;
    configuraciones(1:size(ct,1), ind:ind+1) = ct(:, 1:2);
end
save resultados03.mat contador_abs configuraciones

e = cputime-tiempo
