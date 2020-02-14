function [size_config] = calculateSize(config, features_file)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

configuration = read_configuration(config);
features  = read_configuration(features_file);

size_config = ((size(configuration,2)-1)/(size(features,2)-1));

end

