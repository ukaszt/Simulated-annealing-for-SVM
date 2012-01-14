function wmh_solve()
    
    %anonymous fun for passing arguments
    %@(u,v) kfun(u,v,p1,p2)
    SVMStruct = svmtrain(training(:, 1:Ncols-1), training(:, Ncols), 'showplot', true, 'kernel_function', 'linear');
    result = svmclassify(SVMStruct,Sample)
    