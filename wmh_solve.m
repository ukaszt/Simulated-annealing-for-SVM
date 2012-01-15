function wmh_solve(kernel_type)

    %trn = dlmread('data/rs_train5_no_headers_mini.txt');
    %tst = dlmread('data/rs_test5_no_headers_mini.txt');
    
    trn = dlmread('data/devtrain.txt');
    tst = dlmread('data/devtest.txt');
    
    [trn_r, trn_c] = size(trn);
    [tst_r, tst_c] = size(tst);
  
    switch kernel_type
        case 'hiperbolic'
            p0 = [1 1];
            min_fun = @(p) svmsa(trn(:, 1:trn_c - 1), trn(:, trn_c), ...
                tst(:, 1:tst_c - 1), tst(:, tst_c),  ...
                @(u, v) kernel_tanh(u, v, p(1), p(2)));     
        case 'polynomial'
            p0 = [-3 -3];
            min_fun = @(p) svmsa(trn(:, 1:trn_c - 1), trn(:, trn_c), ...
                tst(:, 1:tst_c - 1), tst(:, tst_c),  ...
                @(u, v) kernel_polynomial(u, v, p(1), p(2), 3));   
    end
    
    options = saoptimset('MaxIter', 1500);
    [x fval] = simulannealbnd(min_fun, p0, [0 -2], [10 10], options);
    
    x
    
    hold on
    svm_classfier = svmtrain(trn(:, 1:(trn_c - 1)), trn(:, trn_c), ...
        'kernel_function', @(u, v) kernel_polynomial(u, v, x(1), x(2), 3), ...
        'autoscale', false, 'showplot', true);
    svmclassify(svm_classfier, tst(:, 1:tst_c - 1), 'showplot', true);
    
    