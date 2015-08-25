% Prueba 1_1, simular un collector de torre central
clc,
close all
clear all

%Definimos las 6 paredes que conforman el collector, donde la pared 6 es la
%entrada del collector (esta pared es imaginaria)

%4to definir el taman;o de la cavidad del colector y su posicion (5 paredes) 
%tamaño HB x AB (alto por ancho):

%pared 1
pared1 = [-2.5,2.5,2.5]; %[metros]
HB_p1 = 5; %[metros]
AB_p1 = 5; %[metros]
%para conocer los vectores s y t de la pared 1 (beta es la inclinacion y gamma la rotacion) 
beta_p1 = pi/2;
gamma_p1 = pi/2;
sp1_norm = [cos(beta_p1)*cos(gamma_p1), cos(beta_p1)*sin(gamma_p1), sin(beta_p1)];
tp1_norm = [cos(gamma_p1),-sin(gamma_p1), 0];
N1 = cross(sp1_norm,tp1_norm);

%pared 2
pared2 = [0,5,2.5]; %[metros]
HB_p2 = 5; %[metros]
AB_p2 = 5; %[metros]
%para conocer los vectores s y t de la pared 2 (beta es la inclinacion y gamma la rotacion) 
beta_p2 = pi/2;
gamma_p2 = 0;
sp2_norm = [cos(beta_p2)*cos(gamma_p2), cos(beta_p2)*sin(gamma_p2), sin(beta_p2)];
tp2_norm = [cos(gamma_p2),-sin(gamma_p2), 0];
N2 = cross(sp2_norm,tp2_norm);

%pared 3
pared3 = [2.5,2.5,2.5]; %[metros]
HB_p3 = 5; %[metros]
AB_p3 = 5; %[metros]
%para conocer los vectores s y t de la pared 3 (beta es la inclinacion y gamma la rotacion) 
beta_p3 = pi/2;
gamma_p3 = pi/2;
sp3_norm = [cos(beta_p3)*cos(gamma_p3), cos(beta_p3)*sin(gamma_p3), sin(beta_p3)];
tp3_norm = [cos(gamma_p3),-sin(gamma_p3), 0];
N3 = cross(sp3_norm,tp3_norm);

%pared 4
pared4 = [0,2.5,0]; %[metros]
HB_p4 = 5; %[metros]
AB_p4 = 5; %[metros]
%para conocer los vectores s y t de la pared 4 (beta es la inclinacion y gamma la rotacion) 
beta_p4 = 0;
gamma_p4 = 0;
sp4_norm = [cos(beta_p4)*cos(gamma_p4), cos(beta_p4)*sin(gamma_p4), sin(beta_p4)];
tp4_norm = [sin(gamma_p4),-cos(gamma_p4), 0];
N4 = cross(sp4_norm,tp4_norm);

%pared 5
pared5 = [0,2.5,5]; %[metros]
HB_p5 = 5; %[metros]
AB_p5 = 5; %[metros]

%para conocer los vectores s y t de la pared 5 (beta es la inclinacion y gamma la rotacion) 
beta_p5 = 0;
gamma_p5 = 0;
sp5_norm = [cos(beta_p5)*cos(gamma_p5), cos(beta_p5)*sin(gamma_p5), sin(beta_p5)];
tp5_norm = [sin(gamma_p5),-cos(gamma_p5), 0];
N5 = cross(sp5_norm,tp5_norm);

%pared 6
pared6 = [0,0,2.5]; %[metros]
HB_p6 = 5; %[metros]
AB_p6 = 5; %[metros]

%para conocer los vectores s y t de la pared 6 (beta es la inclinacion y gamma la rotacion) 
beta_p6 = pi/2;
gamma_p6 = 0;
sp6_norm = [cos(beta_p6)*cos(gamma_p6), cos(beta_p6)*sin(gamma_p6), sin(beta_p6)];
tp6_norm = [cos(gamma_p6),-sin(gamma_p6), 0];
N6 = cross(sp6_norm,tp6_norm);

%%%%%Definimos el heliostato

OH1 = [0,-5,2.5]; %posición del centro del heliostato
HH = 5; %[metros] 
AH = 5; %[metros] 

%para conocer los vectores s y t del heliostato (beta es la inclinacion y gamma la rotacion) 
beta_h = pi/2;
gamma_h = 0;
sh_norm = [cos(beta_h)*cos(gamma_h), cos(beta_h)*sin(gamma_h), sin(beta_h)];
th_norm = [cos(gamma_h),-sin(gamma_h), 0];
NH = cross(sh_norm,th_norm);

%Generamos rayos que salen del heliostato
sig_sl = 0.000; %[slope]
sig_sp = 0.003; %[speculacion]
sig = sqrt(4*sig_sl^2+sig_sp^2);

c = 1000000;
num1 = rand(c,4);
sum=0;
abs1=0;
abs2=0;
abs3=0;
abs4=0;
abs5=0;
abs6=0; %se salen de la cavidad
b=5;
for i=1:10000
    teta_r =(sqrt(-2*sig^2*log(1-num1(i,1))));
    phi_r = num1(i,2)*2*pi;
    rayr = sin(teta_r).*sin(phi_r)*th_norm + sin(teta_r).*cos(phi_r)*sh_norm + cos(teta_r)*NH;
    P_h = OH1 + (AH*num1(i,3)-(AH/2))*sh_norm + (HH*num1(i,4)-(HH/2))*th_norm;
    %rayos que entran en la cavidad
    d6 = dot((pared6-P_h),N6)./dot(rayr,N6);
    Pp6 = P_h + (d6.*rayr);
    tp6_rev = abs(dot(tp6_norm,(Pp6-pared6)));
    sp6_rev = abs(dot(sp6_norm,(Pp6-pared6)));
    
    if (tp6_rev <= HB_p6/2) && (sp6_rev <= AB_p6/2)    
        sum=sum+1;
        marc=0;
        corrida     
    end   
    
end


%Generamos los puntos en las paredes 
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

%generamos puntos en la pared 6
rand6 = rand(c,2);
P_p6 = ones(c,1)*pared6 + (AB_p6*rand6(:,1)-(AB_p6/2))* sp6_norm + (HB_p6*rand6(:,2)-(HB_p6/2))* tp6_norm;

%generamos puntos en la pared 6
randh = rand(c,2);
P_h = ones(c,1)*OH1 + (AH*randh(:,1)-(AH/2))*sh_norm + (HH*randh(:,2)-(HH/2))*th_norm;

%grafica
figure,
plot3(P_p1(:,1),P_p1(:,2),P_p1(:,3),'*r');
hold on,
plot3(P_p2(:,1),P_p2(:,2),P_p2(:,3),'*y');
hold on,
plot3(P_p3(:,1),P_p3(:,2),P_p3(:,3),'*b');
hold on,
plot3(P_p4(:,1),P_p4(:,2),P_p4(:,3),'*g');
hold on,
plot3(P_p5(:,1),P_p5(:,2),P_p5(:,3),'*magenta');
hold on,
plot3(P_p6(:,1),P_p6(:,2),P_p6(:,3),'*y');
hold on,
plot3(P_h(:,1),P_h(:,2),P_h(:,3),'*b');
xlabel(' X ') % x-axis label
ylabel(' Y ') % y-axis label
zlabel(' Z ') % z-axis label
hold off,
