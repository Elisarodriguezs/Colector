
file_name = 'corrida1.m';
marc=marc+1;

        %revisar si el rayo intersecta la pared 2
        d2 = dot((pared2-P_h),N2)./dot(rayr,N2);
        Pp2 = P_h + (d2.*rayr);
        tp2_rev = abs(dot(tp2_norm,(Pp2-pared2)));
        sp2_rev = abs(dot(sp2_norm,(Pp2-pared2)));
        if (tp2_rev <= HB_p2/2) && (sp2_rev <= AB_p2/2)
         %si el rayo se ha reflejado "b" veces, se absorbera en la pared
            if marc==b
              abs2=abs2+1;
            %para saber si el rayo se absorbe el num aleatorio debe ser
            %menor a 0.8, si es mayor el rayo se refleja
            else ran1 = rand(1,1);
                if ran1<0.8
                    abs2=abs2+1;
                else
                rayr = -(2*(dot(rayr,N2).*N2)-rayr);
                corrida2
                end
            end
        end
        
        %revisar si el rayo intersecta la pared 3
        d3 = dot((pared3-P_h),N3)./dot(rayr,N3);
        Pp3 = P_h + (d3.*rayr);
        tp3_rev = abs(dot(tp3_norm,(Pp3-pared3)));
        sp3_rev = abs(dot(sp3_norm,(Pp3-pared3)));
        if (tp3_rev <= HB_p3/2) && (sp3_rev <= AB_p3/2)
            %si el rayo se ha reflejado "b" veces, se absorbera en la pared
            if marc==b
              abs3=abs3+1;
             %para saber si el rayo se absorbe el num aleatorio debe ser
            %menor a 0.8, si es mayor el rayo se refleja
            else ran1 = rand(1,1);
            if ran1<0.8
                abs3=abs3+1;
            else
               rayr = -(2*(dot(rayr,N3).*N3)-rayr);
               corrida3
            end
            end
        end
            
        %revisar si el rayo intersecta la pared 
        d4 = dot((pared4-P_h),N4)./dot(rayr,N4);
        Pp4 = P_h + (d4.*rayr);
        tp4_rev = abs(dot(tp4_norm,(Pp4-pared4)));
        sp4_rev = abs(dot(sp4_norm,(Pp4-pared4)));
        if (tp4_rev <= HB_p4/2) && (sp4_rev <= AB_p4/2)
        %si el rayo se ha reflejado "b" veces, se absorbera en la pared
            if marc==b
              abs4=abs4+1;
            %para saber si el rayo se absorbe el num aleatorio debe ser
            %menor a 0.8, si es mayor el rayo se refleja
            else ran1 = rand(1,1);
            if ran1<0.8
                abs4=abs4+1;
            else
               rayr = -(2*(dot(rayr,N4).*N4)-rayr);
               corrida4
            end
            end
        end
       
           %revisar si el rayo intersecta la pared 5
        d5 = dot((pared5-P_h),N5)./dot(rayr,N5);
        Pp5 = P_h + (d5.*rayr);
        tp5_rev = abs(dot(tp5_norm,(Pp5-pared5)));
        sp5_rev = abs(dot(sp5_norm,(Pp5-pared5)));
        if (tp5_rev <= HB_p5/2) && (sp5_rev <= AB_p5/2)
             %si el rayo se ha reflejado "b" veces, se absorbera en la pared
            if marc==b
              abs5=abs5+1;
         %para saber si el rayo se absorbe el num aleatorio debe ser
            %menor a 0.8, si es mayor el rayo se refleja
            else
                ran1 = rand(1,1);
                if ran1<0.8
                abs5=abs5+1;
                else
               rayr = -(2*(dot(rayr,N5).*N5)-rayr);
               corrida5
                end
            end
        end
                 
            %revisar si el rayo intersecta la pared 6
         d6 = dot((pared6-P_h),N6)./dot(rayr,N6);
         Pp6 = P_h + (d6.*rayr);
         tp6_rev = abs(dot(tp6_norm,(Pp6-pared6)));
         sp6_rev = abs(dot(sp6_norm,(Pp6-pared6)));
         if (tp6_rev <= HB_p6/2) && (sp6_rev <= AB_p6/2)    
             abs6=abs6+1;
         end