% Prueba 10, simular un collector de torre central
clc,
close all
clear all

%@@@@@@@@@@@@@@@@@@@@@@@ PRIMERA PARTE @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

%Primero es necesario calcular el vector solar, para ello necesitamos
%conocer el angulo zenital y azimutal, eso se hace a continuacion:

%1ro calculamos el day angle (Y), con ello es posibe calcular la ecuación 
%de tiempo, ET, para lo cual es necesario conocer el día del año (N):

N = 1;      %dia del año
Y = 2*pi()*(N-1)/365; %[radianes]
Yd = Y*180/pi(); %[grados]
ET = (0.000075+0.001868*cos(Y)-0.032077*sin(Y)-0.014615*cos(2*Y)-0.048089*sin(2*Y))*(229.18); %[min]

%2do se calcula el tiempo solar aparente, AST, para lo cua se requiere
%proporcionar el tiempo local estandar, LST (la hora que marca nuestro
%reloj), la longitud estandar, SL, y la longitud local del lugar, LL:

LST = [12,00]; %
SL = 105; %En grados 105
LL = 110.95;  %en grados 110.95
AST1 = (LST(1,1)*60+LST(1,2)+ET+(4*(SL-LL)))/60;
AST = [floor(AST1),round((AST1-floor(AST1))*60)]; %[horas,min]

%3ro calculamos el angulo horario, h, las horas despues de medio dia se 
%consideran con signo positivo, para lo cual requerimos conocer la latitud 
%local, L;

L = 29.05; %[en grados]
h = (AST1-12)*15;


%4to calculamos decinacion solar, delta, en grados:

delta = (0.006918-0.399912*cos(Y)+0.070257*sin(Y)-0.006758*cos(2*Y)+0.000907*sin(2*Y)-00.002697*cos(3*Y)+0.00148*sin(3*Y))*(180/pi()); %[grados]

%5to calculamos el angulo zenital, phi y el angulo solar de altitud alpha;

phi =acosd(sind(delta)*sind(L)+cosd(delta)*cosd(L)*cosd(h)); %[grados]
alpha = 90-phi; %[grados]

%7mo calculamos el angulo azimutal, Z;

Z = acosd((sind(alpha)*sind(L)-sind(delta))/(cosd(alpha)*cosd(L)));
if h>0
    Z=-Z;
end

%Finalmente definimos el vector solar:

s_norm = [-cosd(alpha)*sind(Z),cosd(alpha)*cosd(Z),sind(alpha)];  %hay que agregarle signo negativo


%@@@@@@@@@@@@@@@@@@@@@@@@@@@ SEGUNDA PARTE @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
%1ro debemos definir donde se localizará el blanco lambertiano y su 
%tamaño HB x AB (alto por ancho), blanco a donde se apuntara el heliostato 
%blanco1, localizacion de la camara "PC1" y "PC2"(se considera como un punto)
%y el heliostato "OH1",asi como las medidas de este ultimo HH x AH 
%(alto por ancho):

blanco = [0,0,2.5]; %[metros]
blanco1 = [0,0,2.5]; %[metros]
HB = 5; %[metros]
AB = 5; %[metros]
OH1 = [0,-40,2.5]; %posición del centro del heliostato
HH = 4; %[metros] 
AH = 4; %[metros] 

%3ro debemos calcular la orientacion del heliostato: 
%inclinacion beta (con respecto a Z) y rotación gamma (con respecto al plano
%Y-Z, en sentido contrario a las manecillas del reloj), asi como los vectores
%sh1_norm y th1_norm:

r_norm = normr(blanco1-OH1);
r_nor = norm(blanco1-OH1);
nh_norm = normr(r_norm+s_norm);
gamma = atand(-nh_norm(1,1)/nh_norm(1,2));  %[grados]
beta = 90-acosd(nh_norm(1,3));  %[grados]

%Ahora poodemos conocer sh1_norm y th1_norm:
sh1_norm = [cosd(gamma),sind(gamma),0];
th1_norm = [cosd(90-(beta))*sind(gamma),-cosd(90-(beta))*cosd(gamma), sind(90-(beta))];

%4to definir el taman;o de la cavidad del colector y su posicion (5 paredes) 
%tamaño HB x AB (alto por ancho):

%pared 1
pared1 = [-2.5,2.5,2.5]; %[metros
HB_p1 = 5; %[metros]
AB_p1 = 5; %[metros]
%para conocer los vectores s y t de la pared 1 (beta es la inclinacion y gamma la rotacion) 
beta_p1 = pi/2;
gamma_p1 = pi/2;
sp1_norm = [cos(beta_p1)*cos(gamma_p1), cos(beta_p1)*sin(gamma_p1), sin(beta_p1)];
tp1_norm = [cos(gamma_p1),-sin(gamma_p1), 0];

%pared 2
pared2 = [0,5,2.5]; %[metros
HB_p2 = 5; %[metros]
AB_p2 = 5; %[metros]
%para conocer los vectores s y t de la pared 1 (beta es la inclinacion y gamma la rotacion) 
beta_p2 = pi/2;
gamma_p2 = 0;
sp2_norm = [cos(beta_p2)*cos(gamma_p2), cos(beta_p2)*sin(gamma_p2), sin(beta_p2)];
tp2_norm = [cos(gamma_p2),-sin(gamma_p2), 0];

%pared 3
pared3 = [2.5,2.5,2.5]; %[metros
HB_p3 = 5; %[metros]
AB_p3 = 5; %[metros]
%para conocer los vectores s y t de la pared 1 (beta es la inclinacion y gamma la rotacion) 
beta_p3 = pi/2;
gamma_p3 = pi/2;
sp3_norm = [cos(beta_p3)*cos(gamma_p3), cos(beta_p3)*sin(gamma_p3), sin(beta_p3)];
tp3_norm = [cos(gamma_p3),-sin(gamma_p3), 0];

%pared 4
pared4 = [0,2.5,0]; %[metros
HB_p4 = 5; %[metros]
AB_p4 = 5; %[metros]
%para conocer los vectores s y t de la pared 1 (beta es la inclinacion y gamma la rotacion) 
beta_p4 = 0;
gamma_p4 = 0;
sp4_norm = [cos(beta_p4)*cos(gamma_p4), cos(beta_p4)*sin(gamma_p4), sin(beta_p4)];
tp4_norm = [sin(gamma_p4),-cos(gamma_p4), 0];

%pared 5
pared5 = [0,2.5,5]; %[metros
HB_p5 = 5; %[metros]
AB_p5 = 5; %[metros]

%para conocer los vectores s y t de la pared 1 (beta es la inclinacion y gamma la rotacion) 
beta_p5 = 0;
gamma_p5 = 0;
sp5_norm = [cos(beta_p5)*cos(gamma_p5), cos(beta_p5)*sin(gamma_p5), sin(beta_p5)];
tp5_norm = [sin(gamma_p5),-cos(gamma_p5), 0];

%generamos puntos en el heliostato

randy = rand(2,1);
c = 1000000; 
d = 0; %porcentaje de error
de = d*.01;
a1 = round(c-(de*c)+randy(1,1)*(2*de*c));
num1_1 = rand(a1,6);
P1 = ones(a1,1)*OH1 + (AH*num1_1(:,1)-(AH/2))* sh1_norm + (HH*num1_1(:,2)-(HH/2))* th1_norm;


%generamos puntos en la pared 1
rand1 = rand(c,2);
P_p1 = ones(c,1)*pared1 + (AB_p1*rand1(:,1)-(AB_p1/2))* sp1_norm + (HB_p1*rand1(:,2)-(HB_p1/2))* tp1_norm;

%generamos puntos en la pared 2
rand2 = rand(c,2);
P_p2 = ones(c,1)*pared2 + (AB_p2*rand2(:,1)-(AB_p2/2))* sp2_norm + (HB_p2*rand2(:,2)-(HB_p2/2))* tp2_norm;

%generamos puntos en la pared 3
rand3 = rand(c,2);
P_p3 = ones(c,1)*pared3 + (AB_p3*rand3(:,1)-(AB_p3/2))* sp3_norm + (HB_p3*rand3(:,2)-(HB_p3/2))* tp3_norm;

%generamos puntos en la pared 4
rand4 = rand(c,2);
P_p4 = ones(c,1)*pared4 + (AB_p4*rand4(:,1)-(AB_p4/2))* sp4_norm + (HB_p4*rand4(:,2)-(HB_p4/2))* tp4_norm;

%generamos puntos en la pared 5
rand5 = rand(c,2);
P_p5 = ones(c,1)*pared5 + (AB_p5*rand5(:,1)-(AB_p5/2))* sp5_norm + (HB_p5*rand5(:,2)-(HB_p5/2))* tp5_norm;

figure,
%plot3(P1(:,1),P1(:,2),P1(:,3),'+r');
%axis([-10 10 -50 10 -10 10])
%hold on,
plot3(P_p1(:,1),P_p1(:,2),P_p1(:,3),'*r');
hold on,
plot3(P_p2(:,1),P_p2(:,2),P_p2(:,3),'*y');
hold on,
plot3(P_p3(:,1),P_p3(:,2),P_p3(:,3),'*b');
hold on,
plot3(P_p4(:,1),P_p4(:,2),P_p4(:,3),'*g');
hold on,
plot3(P_p5(:,1),P_p5(:,2),P_p5(:,3),'*g');
xlabel(' X ') % x-axis label
ylabel(' Y ') % y-axis label
zlabel(' Z ') % z-axis label
hold off,

%para conocer los vectores s y t del blanco (beta es la inclinacion y gamma la rotacion) 
beta2 = pi/2;
gamma2 = 0;
sb1_norm = [cos(beta2)*cos(gamma2), cos(beta2)*sin(gamma2), sin(beta2)];
tb1_norm = [cos(gamma2),-sin(gamma2), 0];
nb_norm = cross(sb1_norm,tb1_norm);



%generamos el error de los rayos
sig_sl = 0.000;
sig_sp = 0.003;
sig1 = sqrt(4*sig_sl^2+sig_sp^2);
sig2 = .00273;

teta2_1 =(sqrt(-2*sig2^2*log(1-num1_1(:,3))));
phi2_1 = num1_1(:,4)*2*pi;

teta2_2 =(sqrt(-2*sig1^2*log(1-num1_1(:,5))));
phi2_2 = num1_1(:,6)*2*pi;

%generamos los rayos que salen del sol

%los ejes coordenados donde s_norm es equivalente a Z
x1s = cross(s_norm,nh_norm);
x2s = cross(s_norm,x1s);

%Aplicamos el error a los rayos que inciden del sol
sh_norms_er1 = [cos(teta2_1).*s_norm(:,1),cos(teta2_1).*s_norm(:,2),cos(teta2_1).*s_norm(:,3)];
sh_norms_er2 = [sin(teta2_1).*cos(phi2_1).*x1s(:,1),sin(teta2_1).*cos(phi2_1).*x1s(:,2),sin(teta2_1).*cos(phi2_1).*x1s(:,3)];
sh_norms_er3 = [sin(teta2_1).*sin(phi2_1).*x2s(:,1),sin(teta2_1).*sin(phi2_1).*x2s(:,2),sin(teta2_1).*sin(phi2_1).*x2s(:,3)];   
sh_norms_er = normr(sh_norms_er1 + sh_norms_er2 + sh_norms_er3); %[vector rh_norm con error incluido]

%calculamos la desviacion en radianes de de sh_norms_er con respecto a
%s_norm

dotsh = dot(nh_norm,s_norm);
teta_sh = acosd(dotsh/(norm(s_norm)*norm(nh_norm)));
rad_bin = 1000*(HH*AH)*cosd(teta_sh)/a1;

%generamos los rayos que salen al blanco
dotp1 = dot(ones(a1,1)*nh_norm,sh_norms_er,2);
rh_normh_er = normr(-(sh_norms_er)+(2*dotp1*nh_norm));


%Para aplicar el error es necesario considerar al rayo generado rh_norm,
%como el eje "z", y x1, x2 como ejes que forman un plano perpendicular a z:
x1h = cross(rh_normh_er,ones(a1,1)*nh_norm);
x2h = cross(rh_normh_er,x1h);


rh_normh_er1 = [cos(teta2_2).*rh_normh_er(:,1),cos(teta2_2).*rh_normh_er(:,2),cos(teta2_2).*rh_normh_er(:,3)];
rh_normh_er2 = [sin(teta2_2).*cos(phi2_2).*x1h(:,1),sin(teta2_2).*cos(phi2_2).*x1h(:,2),sin(teta2_2).*cos(phi2_2).*x1h(:,3)];
rh_normh_er3 = [sin(teta2_2).*sin(phi2_2).*x2h(:,1),sin(teta2_2).*sin(phi2_2).*x2h(:,2),sin(teta2_2).*sin(phi2_2).*x2h(:,3)];   
rh_normh_er = normr(rh_normh_er1 + rh_normh_er2 + rh_normh_er3); %[vector rh_norm con error incluido]

%encontramos d para localizar los puntos de impacto
dist = dot(ones(a1,1)*blanco-P1,ones(a1,1)*nb_norm,2)./dot(rh_normh_er,ones(a1,1)*nb_norm,2);

%los puntos en el blanco son:
pts = [dist,dist,dist].*rh_normh_er + P1;
pts1 = [pts(:,1),pts(:,3)];
pts2 = pts;

dot_t_pr= (pts(:,1)-blanco(1,1))*tb1_norm(1,1) + (pts(:,2)-blanco(1,2))*tb1_norm(1,2)+ (pts(:,3)-blanco(1,3))*tb1_norm(1,3);
dot_s_pr= (pts(:,1)-blanco(1,1))*sb1_norm(1,1) + (pts(:,2)-blanco(1,2))*sb1_norm(1,2)+ (pts(:,3)-blanco(1,3))*sb1_norm(1,3);

sum = 0;
for cont= 1:c
    if (d(cont,1)>0) && (abs(dot_t_pr(cont)) <= (HB/2)) && (abs(dot_s_pr(cont)) <= (AB/2)) 
        sum = sum + 1;   
    else pts2(cont,:)= 0;
    end
end