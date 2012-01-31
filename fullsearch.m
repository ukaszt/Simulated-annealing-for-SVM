function fullsearch(trn, tst, kernel_type)

    params = 0;
   
    switch kernel_type 
        case 'poly3'
            lb = [0 0] - [10 10];
            up = [0 0] + [10 10];
            params = 2;
            min_fun = @(p) svmsa(trn(:, 1:end - 1), trn(:, end), ...
                tst(:, 1:end - 1), tst(:, end),  ...
                @(u, v) kernel_polynomial(u, v, p(1), p(2), 3));
        case 'matlab_rbf'
            disp('Full search with RBF kernel');
            lb = 1;
            up = 30;
            params = 1;
            min_fun = @(p) svmsa(trn(:, 1:end - 1), trn(:, end), ...
                tst(:, 1:end - 1), tst(:, end), 'rbf', p(1));
        case 'tanh'
            lb = [0 0] - [10 10];
            up = [0 0] + [10 10];
            params = 2;
            min_fun = @(p) svmsa(trn(:, 1:trn_c - 1), trn(:, trn_c), ...
                tst(:, 1:tst_c - 1), tst(:, tst_c),  ...
                @(u, v) kernel_tanh(u, v, p(1), p(2)));
    end
    
    step = 0.2;
    
    min = Inf; 
    minp1 = 0;
    minp2 = 0;
    
    params
    lb
    up
    
    tic
    switch params
        case 1
            for i = lb:step:up
                cmin = min_fun(i);
                if cmin < min
                    min = cmin;
                    minp1 = i;
                end
                fprintf('Param = %d, Err = %d \n', i, cmin);
            end
        case 2
            for i = lb:step:up
                for j = lb:step:up
                    fprintf('Checking i = %d j = %d \n', i, j);
                    cmin = min_fun([i j]);
                    if cmin < min
                        min = cmin;
                        minp1 = i;
                        minp2 = j;
                    end
                end
            end
    end
    toc
    
    min
    minp1
    minp2
    
end

