% Analiza los datos obtenidos

clear all
close all

%% Abre y junta los archivos de datos
load resultados01.mat
l = find(sum(contador_abs, 2) > 0, 1, 'last');
conf_tot = configuraciones(:, 1:2*l);
cont_tot = contador_abs(1:l, :);

load resultados02.mat
l = find(sum(contador_abs, 2) > 0, 1, 'last');
conf_tot = [conf_tot, configuraciones(:, 1:2*l)];
cont_tot = [cont_tot; contador_abs(1:l, :)];

load resultados03.mat
l = find(sum(contador_abs, 2) > 0, 1, 'last');
conf_tot = [conf_tot, configuraciones(:, 1:2*l)];
cont_tot = [cont_tot; contador_abs(1:l, :)];

% % load resultados04.mat
% % conf_tot = [conf_tot, configuraciones];
% % cont_tot = [cont_tot; contador_abs];
% % 
% % load resultados05.mat
% % conf_tot = [conf_tot, configuraciones];
% % cont_tot = [cont_tot; contador_abs];

%% Obtiene indices

% En primer lugar los ordenamos por números de rayos que salen (de menos a
% mas).
[cont_sort_queda, ind_queda] = sort(cont_tot(:,6));

% En segundo lugar los ordenamos por absroción en los tubos (de menos a
% mas)
[cont_sort_tubos, ind_tubos] = sort(sum(cont_tot(:, 7:end), 2));

% En tercer lugar los ordenamos por desviación estandard entre los tubos
% (de menos a mas)
[cont_sort_std, ind_std] = sort(std(cont_tot(:, 7:end), 1, 2));

%% Grafica las figuras con las diferentes configuraciones

% figure(1)
% subplot(221); 
% ind = 2 * (ind_queda(1) -1) - 1;
% plot(conf_tot(:,ind), conf_tot(:,ind+1), 'r*');
% title(['Deja salir ', int2str(cont_sort_queda(1)), ' rayos'], 'Fontsize', 16);
% 
% subplot(222); 
% ind = 2 * (ind_queda(2) -1) - 1;
% plot(conf_tot(:,ind), conf_tot(:,ind+1), 'r*');
% title(['Deja salir ', int2str(cont_sort_queda(2)), ' rayos'], 'Fontsize', 16);
% 
% subplot(223); 
% ind = 2 * (ind_queda(3) -1) - 1;
% plot(conf_tot(:,ind), conf_tot(:,ind+1), 'r*');
% title(['Deja salir ', int2str(cont_sort_queda(3)), ' rayos'], 'Fontsize', 16);
% 
% subplot(224); 
% ind = 2 * (ind_queda(4) -1) - 1;
% plot(conf_tot(:,ind), conf_tot(:,ind+1), 'r*');
% title(['Deja salir ', int2str(cont_sort_queda(4)), ' rayos'], 'Fontsize', 16);
% 
% figure(2)
% subplot(221); 
% ind = 2 * (ind_queda(end) -1) - 1;
% plot(conf_tot(:,ind), conf_tot(:,ind+1), 'r*');
% title(['Deja salir ', int2str(cont_sort_queda(end)), ' rayos'], 'Fontsize', 16);
% 
% subplot(222); 
% ind = 2 * (ind_queda(end-1) -1) - 1;
% plot(conf_tot(:,ind), conf_tot(:,ind+1), 'r*');
% title(['Deja salir ', int2str(cont_sort_queda(end - 1)), ' rayos'], 'Fontsize', 16);
% 
% subplot(223); 
% ind = 2 * (ind_queda(end-2) -1) - 1;
% plot(conf_tot(:,ind), conf_tot(:,ind+1), 'r*');
% title(['Deja salir ', int2str(cont_sort_queda(end - 2)), ' rayos'], 'Fontsize', 16);
% 
% subplot(224); 
% ind = 2 * (ind_queda(end-3) -1) - 1;
% plot(conf_tot(:,ind), conf_tot(:,ind+1), 'r*');
% title(['Deja salir ', int2str(cont_sort_queda(end - 3)), ' rayos'], 'Fontsize', 16);
% 

% figure(1)
% subplot(221); 
% ind = 2 * (ind_tubos(1) -1) - 1;
% plot(conf_tot(:,ind), conf_tot(:,ind+1), 'r*');
% title(['Absorbe en los tubos  ', int2str(cont_sort_tubos(1)), ' rayos'], 'Fontsize', 16);
% 
% subplot(222); 
% ind = 2 * (ind_tubos(2) -1) - 1;
% plot(conf_tot(:,ind), conf_tot(:,ind+1), 'r*');
% title(['Absorbe en los tubos  ', int2str(cont_sort_tubos(2)), ' rayos'], 'Fontsize', 16);
% 
% subplot(223); 
% ind = 2 * (ind_tubos(3) -1) - 1;
% plot(conf_tot(:,ind), conf_tot(:,ind+1), 'r*');
% title(['Absorbe en los tubos  ', int2str(cont_sort_tubos(3)), ' rayos'], 'Fontsize', 16);
% 
% subplot(224); 
% ind = 2 * (ind_tubos(4) -1) - 1;
% plot(conf_tot(:,ind), conf_tot(:,ind+1), 'r*');
% title(['Absorbe en los tubos  ', int2str(cont_sort_tubos(4)), ' rayos'], 'Fontsize', 16);
% 
% figure(2)
% subplot(221); 
% ind = 2 * (ind_tubos(end) -1) - 1;
% plot(conf_tot(:,ind), conf_tot(:,ind+1), 'r*');
% title(['Absorbe en los tubos  ', int2str(cont_sort_tubos(end)), ' rayos'], 'Fontsize', 16);
% 
% subplot(222); 
% ind = 2 * (ind_tubos(end-1) -1) - 1;
% plot(conf_tot(:,ind), conf_tot(:,ind+1), 'r*');
% title(['Absorbe en los tubos  ', int2str(cont_sort_tubos(end - 1)), ' rayos'], 'Fontsize', 16);
% 
% subplot(223); 
% ind = 2 * (ind_tubos(end-2) -1) - 1;
% plot(conf_tot(:,ind), conf_tot(:,ind+1), 'r*');
% title(['Absorbe en los tubos  ', int2str(cont_sort_tubos(end - 2)), ' rayos'], 'Fontsize', 16);
% 
% subplot(224); 
% ind = 2 * (ind_tubos(end-3) -1) - 1;
% plot(conf_tot(:,ind), conf_tot(:,ind+1), 'r*');
% title(['Absorbe en los tubos  ', int2str(cont_sort_tubos(end - 3)), ' rayos'], 'Fontsize', 16);
% 

figure(1)
subplot(221); 
ind = 2 * (ind_std(1) -1) - 1;
plot(conf_tot(:,ind), conf_tot(:,ind+1), 'r*');
title(['std de abs. en tubos =   ', int2str(cont_sort_std(1)), ' rayos'], 'Fontsize', 16);

subplot(222); 
ind = 2 * (ind_std(2) -1) - 1;
plot(conf_tot(:,ind), conf_tot(:,ind+1), 'r*');
title(['std de abs. en tubos =   ', int2str(cont_sort_std(2)), ' rayos'], 'Fontsize', 16);

subplot(223); 
ind = 2 * (ind_std(3) -1) - 1;
plot(conf_tot(:,ind), conf_tot(:,ind+1), 'r*');
title(['std de abs. en tubos =   ', int2str(cont_sort_std(3)), ' rayos'], 'Fontsize', 16);

subplot(224); 
ind = 2 * (ind_std(4) -1) - 1;
plot(conf_tot(:,ind), conf_tot(:,ind+1), 'r*');
title(['std de abs. en tubos =   ', int2str(cont_sort_std(4)), ' rayos'], 'Fontsize', 16);

figure(2)
subplot(221); 
ind = 2 * (ind_std(end) -1) - 1;
plot(conf_tot(:,ind), conf_tot(:,ind+1), 'r*');
title(['std de abs. en tubos =   ', int2str(cont_sort_std(end)), ' rayos'], 'Fontsize', 16);

subplot(222); 
ind = 2 * (ind_std(end-1) -1) - 1;
plot(conf_tot(:,ind), conf_tot(:,ind+1), 'r*');
title(['std de abs. en tubos =   ', int2str(cont_sort_std(end - 1)), ' rayos'], 'Fontsize', 16);

subplot(223); 
ind = 2 * (ind_std(end-2) -1) - 1;
plot(conf_tot(:,ind), conf_tot(:,ind+1), 'r*');
title(['std de abs. en tubos =   ', int2str(cont_sort_std(end - 2)), ' rayos'], 'Fontsize', 16);

subplot(224); 
ind = 2 * (ind_std(end-3) -1) - 1;
plot(conf_tot(:,ind), conf_tot(:,ind+1), 'r*');
title(['std de abs. en tubos =   ', int2str(cont_sort_std(end - 3)), ' rayos'], 'Fontsize', 16);


