function [ output_args ] = fullsearch(params, lb, up, step, kernel_type)
    trn = dlmread('data/rs_train5_no_headers_mini.txt');
    tst = dlmread('data/rs_test5_no_headers_mini.txt');
    
    min = Inf; 
    
    switch kernel_type
        case 'hiperbolic'
            min_fun = @(p) svmsa(trn(:, 1:trn_c - 1), trn(:, trn_c), ...
                tst(:, 1:tst_c - 1), tst(:, tst_c),  ...
                @(u, v) kernel_tanh(u, v, p(1), p(2)));     
        case 'polynomial'
            min_fun = @(p) svmsa(trn(:, 1:trn_c - 1), trn(:, trn_c), ...
                tst(:, 1:tst_c - 1), tst(:, tst_c),  ...
                @(u, v) kernel_polynomial(u, v, p(1), p(2), 3));
        case 'rbf'
            min_fun = @(p) svmsa(trn(:, 1:trn_c - 1), trn(:, trn_c), ...
                tst(:, 1:tst_c - 1), tst(:, tst_c),  ...
                @(u, v) kernel_rbf(u, v, p(1)));
        case 'tanh'
            min_fun = @(p) svmsa(trn(:, 1:trn_c - 1), trn(:, trn_c), ...
                tst(:, 1:tst_c - 1), tst(:, tst_c),  ...
                @(u, v) kernel_tanh(u, v, p(1), p(2)));
    end
    
    switch params
        case 1
            for i = lb:step:up
                cmin = min_fun(i);
                if cmin < min
                    min = cmin;
                end
            end
        case 2
            for i = lb:step:up
                for j = lb:step:up
                    cmin = min_fun([i j]);
                    if cmin < min
                        min = cmin;
                    end
                end
            end
    end
end

