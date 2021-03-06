function [con_p, P_a] = simulador_rayos(pared, N, Pp_1, rayo1, ct )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

conerr = 0;
c2 = size(Pp_1,1);

con_p = zeros(1,((size(pared,1)-1)+size(ct,1))); %8 entradas, 1 para cada pared y 1 para cada tubo
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
 
if c2 ~= sum(con_p)
    error('Los rayos que entran deben de ser igual a los rayos que se absorben');
end

end

