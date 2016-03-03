function [rayo, P_e] = reflejado12_2(rayo, Ni, P_e, di)
%rayo reflejado

P_e = P_e + di * rayo;
rayo1 = 2*(dot(-rayo,Ni).*Ni)+rayo; %rayo reflejado
rayo = rayo1/norm(rayo1);
ba=0;

if rand < 0.5 && ba == 1
%error para los rayos
sig_slr = 0.0; %[slope]
sig_spr = 0.003; %[speculacion] 0.003
sigr = sqrt(4*sig_slr^2+sig_spr^2);

num2 = rand(1,2);
%angulos de inclinaci[on y rotacion de los rayos debido al error sig
teta_r1 =(sqrt(-2*sigr^2*log(1-num2(:,1))));
phi_r1 = num2(:,2)*2*pi;

z1 = [0,0,1];
thnor = cross(z1,rayo);
shnor = cross(thnor,rayo);
%rayo generado con los angulos teta y phi
rayito = sin(teta_r1).*sin(phi_r1)*thnor + sin(teta_r1).*cos(phi_r1)*shnor + cos(teta_r1)*rayo;
rayo = rayito;
rayo = rayo/norm(rayo);
end


