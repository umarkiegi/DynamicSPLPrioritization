function paths = managePaths
    %managePaths Defines and initialises required project directory paths

    % Define project directory paths
    cd('..\..');                            % move to parent directory
    paths.project = pwd;                    % define project directory path
    paths.in = strcat(pwd,'\in');           % define project input directory path
    paths.fun = strcat(pwd,'\fun');         % define project functions directory path
    paths.stage = strcat(pwd,'\stage');     % define project stage directory path
    paths.out = strcat(pwd,'\out');         % define project output/restuls directory path

    % Add project directory paths
    addpath(genpath(paths.fun));
    addpath(genpath(paths.in));
    addpath(genpath(paths.stage));
end