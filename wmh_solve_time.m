function ret = wmh_solve(kernel_type, time, safun)

    trn = dlmread('data/rs_train7_no_headers.txt');
    tst = dlmread('data/rs_test7_no_headers.txt');
        
    %tst = dlmread('data/rs_test7_short.csv', ',');
    %trn = dlmread('data/rs_train7_short.csv', ',');
    
    %trn = dlmread('data/mltclass_train.txt');
    %tst = dlmread('data/mltclass_test.txt');
    
    [trn_r, trn_c] = size(trn);
    [tst_r, tst_c] = size(tst);
  
    switch kernel_type
        case 'hiperbolic'
            p0 = [1 1];
            min_fun = @(p) svmsa(trn(:, 1:trn_c - 1), trn(:, trn_c), ...
                tst(:, 1:tst_c - 1), tst(:, tst_c),  ...
                @(u, v) kernel_tanh(u, v, p(1), p(2)));     
        case 'polynomial3'
            p0 = [0 0];
            min_fun = @(p) svmsa(trn(:, 1:trn_c - 1), trn(:, trn_c), ...
                tst(:, 1:tst_c - 1), tst(:, tst_c),  ...
                @(u, v) kernel_polynomial(u, v, p(1), p(2), 3));
        case 'polynomial2'
            p0 = [0 0];
            min_fun = @(p) svmsa(trn(:, 1:trn_c - 1), trn(:, trn_c), ...
                tst(:, 1:tst_c - 1), tst(:, tst_c),  ...
                @(u, v) kernel_polynomial(u, v, p(1), p(2), 2));
        case 'rbf'
            p0 = [1];
            min_fun = @(p) svmsa(trn(:, 1:end - 1), trn(:, end), ...
                tst(:, 1:end - 1), tst(:, end), 'rbf');
        case 'tanh'
            p0 = [0 0];
            min_fun = @(p) svmsa(trn(:, 1:trn_c - 1), trn(:, trn_c), ...
                tst(:, 1:tst_c - 1), tst(:, tst_c),  ...
                @(u, v) kernel_tanh(u, v, p(1), p(2)));
    end
    
    lbs = [[-10 -10];[0 0]];
    ubs = [[10 10];[0 0]];
    p0s = [[0 0];[0 0]];
    
    tempfuns = cell(1,3);
    tempfuns{1} = [@temperatureboltz];
    tempfuns{2} = [@temperaturefast];
    tempfuns{3} = [@temperatureexp];
    inittemps = [100 500 2000];
    
    combs = [1 1
        1 2
        1 3
        2 1
        2 2
        2 3
        3 1
        3 2
        3 3];
    combsn = size(combs);
 
    ret = zeros(1, 4);
    for ii=1:combsn(1),
        disp(sprintf('ii: %d', ii));
        
        basicOpts = saoptimset('simulannealbnd');
        options = saoptimset(basicOpts, 'TimeLimit', time, 'AnnealingFcn', safun, ...
                            'InitialTemperature', inittemps(combs(ii, 2)),...
                            'TemperatureFcn', tempfuns{combs(ii, 1)});
        [x, fval, exitflag, output] = simulannealbnd(min_fun, p0s(1,:), lbs(1,:), ubs(1,:), options);

        fintemp  = getfield(output, 'temperature');
        numiter  = getfield(output, 'iterations');
        totime   = getfield(output, 'totaltime');
                
        disp('fval numiter totime fintemp');
        result = [fval numiter totime fintemp(1)];
        ret = vertcat(ret, result);
    end
    ret=ret(2:end,:);
    %hold on
    %svm_classfier = svmtrain(trn(:, 1:(trn_c - 1)), trn(:, trn_c), ...
    %    'kernel_function', @(u, v) kernel_polynomial(u, v, x(1), x(2), 3), ...
    %    'autoscale', false, 'showplot', false);
    %groups = svmclassify(svm_classfier, tst(:, 1:tst_c - 1), 'showplot',
    %true)