function disableWarnings
    %disableWarnings Defines warning messages to be disabled

    
    % Get last warning message
    % [msg,msgID] = lastwarn
    % use provided msgID to disable warnings
    
    % List of warnings to be disabled
    warning('off','MATLAB:xlswrite:AddSheet');
    
end