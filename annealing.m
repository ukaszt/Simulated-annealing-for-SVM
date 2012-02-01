function annealing(trn, tst, kernel_type, time, saopt)

    %trn = dlmread('data/rs_train7_no_headers.txt');
    %tst = dlmread('data/rs_test7_no_headers.txt');
    
    
    %tst = dlmread('data/rs_test7_short.csv', ',');
    %trn = dlmread('data/rs_train7_short.csv', ',');
    
    %trn = dlmread('data/mltclass_train.txt');
    %tst = dlmread('data/mltclass_test.txt');
    
    [trn_r, trn_c] = size(trn);
    [tst_r, tst_c] = size(tst);
  
    switch kernel_type    
        case 'poly3'
            p0 = [0 0];
            min_fun = @(p) svmsa(trn(:, 1:trn_c - 1), trn(:, trn_c), ...
                tst(:, 1:tst_c - 1), tst(:, tst_c),  ...
                @(u, v) kernel_polynomial(u, v, p(1), p(2), 3));
        case 'poly2'
            p0 = [0 0];
            min_fun = @(p) svmsa(trn(:, 1:trn_c - 1), trn(:, trn_c), ...
                tst(:, 1:tst_c - 1), tst(:, tst_c),  ...
                @(u, v) kernel_polynomial(u, v, p(1), p(2), 2));
        case 'tanh'
            p0 = [0 0];
            min_fun = @(p) svmsa(trn(:, 1:trn_c - 1), trn(:, trn_c), ...
                tst(:, 1:tst_c - 1), tst(:, tst_c),  ...
                @(u, v) kernel_tanh(u, v, p(1), p(2)));
            
        % --=> MATLAB KERNELS <=-- %
            
        case 'matlab_rbf'
            p0 = [1];
            min_fun = @(p) svmsa(trn(:, 1:end - 1), trn(:, end), ...
                tst(:, 1:end - 1), tst(:, end), 'rbf', p(1));
            
        case 'matlab_poly3'
            p0 = [2];
            min_fun = @(p) svmsa(trn(:, 1:trn_c - 1), trn(:, trn_c), ...
                tst(:, 1:tst_c - 1), tst(:, tst_c),  ...
                'polynomial');
    end
    

    %xbest = Inf;
    %for i = 1:10
        %p0 = rand(1,2) * 100
         saopt = saoptimset(saopt, 'OutputFcns',@annealdisplay);
         saopt
        [x,fval,exitflag,output] = simulannealbnd(min_fun, p0, p0, p0 + 30, saopt);
    %    if xbest > x
    %        xbest = x;
    %    end
    %end
    
    x
    fval
    output

    