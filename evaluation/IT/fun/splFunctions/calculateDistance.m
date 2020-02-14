function [distance] = calculateDistance(c1,c2,features_file)
%calculateDistance Calculates distance between two .config files
%   Detailed explanation goes here


%c1 = '3.config';
%c2 = '3.config';
%features_file = 'Features.config';

%c1
con1 = read_configuration(c1);
con2 = read_configuration(c2);
features  = read_configuration(features_file);

%delta_adds(i) = 

m=1;
n=1;
o=1;
p=1;


%Bucle que detecta componentes iguales
for i=1:size(con2,2)-1;
    
    variant_feature = strtok(con2(1,i));
    add_delta = false;
    for j=1:size(con1,2)-1;
        core_feature = strtok(con1(1,j));
        if strcmp(variant_feature,core_feature)
            add_delta = true;
        end
    end
    if add_delta ==true
       same_component(m) = variant_feature; 
       m= m+1;
    end
    
end

for i=1:size(features,2);
    
    variant_feature = strtok(features(1,i));
    add_delta = true;
    for j=1:size(con1,2)-1;
        core_feature = strtok(con1(1,j));
        if strcmp(variant_feature,core_feature)
            add_delta = false;
        end
    end
    if add_delta ==true
       elements_1(n) = variant_feature; 
       n= n+1;
    end
    
end


for i=1:size(features,2);
    
    variant_feature = strtok(features(1,i));
    add_delta = true;
    for j=1:size(con2,2)-1;
        core_feature = strtok(con2(1,j));
        if strcmp(variant_feature,core_feature)
            add_delta = false;
        end
    end
    if add_delta ==true
       elements_2(o) = variant_feature; 
       o= o+1;
    end
    
end


for i=1:size(elements_2,2);
    
    variant_feature = strtok(elements_2(1,i));
    add_delta = false;
    for j=1:size(elements_1,2)-1;
        core_feature = strtok(elements_1(1,j));
        if strcmp(variant_feature,core_feature)
            add_delta = true;
        end
    end
    if add_delta ==true
       same_component_2(p) = variant_feature; 
       p= p+1;
    end
    
end

%Formula distancia sacada de Al-Hajjaji2014

distance = 1 - ((size(same_component,2)-1)+(size(same_component_2,2)))/(size(features,2)-2);

%TODO: detectar features que haya que remplazar y los features que haya que
%modificar... para ello supongo que ya tendría que entrar el xml del
%feature model


end

