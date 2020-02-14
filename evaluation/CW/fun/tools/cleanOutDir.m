function cleanOutDir(paths)
    %cleanOutDir Deletes the out dir if exists and creates an empty one
    
    if exist(paths.out,'dir')
        rmdir(paths.out, 's');
    end
    mkdir(paths.out);

end