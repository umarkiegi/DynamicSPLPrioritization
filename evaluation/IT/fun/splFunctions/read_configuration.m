% A partir de un archivos .config obtiene las configuraciones

% 

function features = read_configuration(config_file)
features = {};

fid = fopen(config_file);
i = 1;
features{1,i}= ' ';
%strings{i}
while features{1,i} ~= -1
    %feat = fgets(fid); %variable feat, para optimización
    features{1,i+1} = fgets(fid);
    
    if features{1,i+1} ~= -1
        features{1,i+1} = regexprep(features{1,i+1}, '"', ''); % Igual que el anterior, solo que se les quita las comillas a los features
    end
    
    i = i+1;
end

fclose(fid);
