
file_name = 'corrida2.m';
marc=marc+1;

%revisar si el rayo intersecta la pared 1
        d1 = dot((pared1-P_h),N1)./dot(rayr,N1);
        Pp1 = P_h + (d1.*rayr);
        tp1_rev = abs(dot(tp1_norm,(Pp1-pared1)));
        sp1_rev = abs(dot(sp1_norm,(Pp1-pared1)));
        if (tp1_rev <= HB_p1/2) && (sp1_rev <= AB_p1/2)
             %si el rayo se ha reflejado "b" veces, se absorbera en la pared
            if marc==b
              abs1=abs1+1;
            %para saber si el rayo se absorbe el num aleatorio debe ser
            %menor a 0.8, si es mayor el rayo se refleja
            else ran1 = rand(1,1);
            if ran1<0.8
                abs1=abs1+1;
            else
               rayr = -(2*(dot(rayr,N1).*N1)-rayr);
               corrida1
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
            
        %revisar si el rayo intersecta la pared 4
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
            else ran1 = rand(1,1);
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
