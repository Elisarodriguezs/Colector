function [p_i, di, N] = impactos(rayo, p_i, P_e, pared, N, ct)   

a1 = 0.999; %valor para que el rayo (por redondeo) no pegue en esquinas de la caja, ni se vaya de paso (por cuestiones de redondeo)


%para revisar si el rayo intersecta, calculamos la distancia del punto
%anterior donde pego a cada una de las paredes, luego establecemos el punto
%de la pared donde pega, si dicho punto se encuentra dentro de las
%dmensiones de la pared y ademas la distancia es positiva, se considera que
%el rayo intersecto la pared. Si alg[un rayo intersecta la pared6
%automaticamente "se absorbe" y se considera que el rayo salio de la
%cavidad.

%revisar la distancia de la pared actual a la siguiente
%___________________________checar que el denominador no sea cero


if (dot(repmat(rayo, 6, 1), N(2:7,:), 2) == 0)
    error('Revisa, el denominador es 0');
end

numerador = dot(pared(2:7, 1:3) - repmat(P_e, 6, 1), N(2:7,:), 2);
denominador = dot( repmat(rayo, 6, 1), N(2:7,:), 2)

d = a1 * numerador ./ denominador;

%revisar la distancia a los tubos------------------------------------------
Ptiv = ct(:,1:2) - repmat(P_e(1:2),size(ct,1),1); %distancia en x y y del punto a los tubos

rtv = repmat(rayo(1:2),size(ct,1),1); 
Pri = dot(Ptiv,rtv,2)./norm(rtv(1,:));
Li = (repmat(P_e(1:2),size(ct,1),1)+rtv.*repmat(Pri,1,2))-ct(:,1:2);
Li = sqrt(Li(:,1).^2+Li(:,2).^2);
ri = zeros(1,size(ct,1));
for pt = 1:size(ct,1)
    if Li(pt)<= ct(pt,3)
        ri(pt) = (Pri(pt)-sqrt(ct(pt,3)^2-Li(pt)^2))*a1;
    else ri(pt)=1e20;
    end
end
%--------------------------------------------------------------------------

d = [d; ri'];
d(d<0) = 1e20;
d(p_i) = 1e20;
p_i = find(d == min(d),1);
di=d(p_i);


p_i1 = size(pared,1)-1;
if p_i > p_i1
    N(p_i+1,:)= rayo*di-[Ptiv(p_i-6,:) 0];
end
