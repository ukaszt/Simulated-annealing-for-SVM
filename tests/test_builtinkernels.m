warning off all

trn = dlmread('data/rs_train7_no_headers.txt');
tst = dlmread('data/rs_test7_no_headers.txt');
    
[trn_r, trn_c] = size(trn);
[tst_r, tst_c] = size(tst);
    
disp('POLYNOMIAL3')
err = svmsa(trn(:, 1:trn_c - 1), trn(:, trn_c), ...
    tst(:, 1:tst_c - 1), tst(:, tst_c),  'polynomial');
err
    
% disp('POLYNOMIAL2')
% err = svmsa(trn(:, 1:trn_c - 1), trn(:, trn_c), ...
%     tst(:, 1:tst_c - 1), tst(:, tst_c),  'polynomial', 'polyorder', 2);
% err
    
disp('QUADRATIC')
err = svmsa(trn(:, 1:trn_c - 1), trn(:, trn_c), ...
    tst(:, 1:tst_c - 1), tst(:, tst_c),  'quadratic');
err
    
disp('RBF')
err = svmsa(trn(:, 1:trn_c - 1), trn(:, trn_c), ...
    tst(:, 1:tst_c - 1), tst(:, tst_c),  'rbf');
err
    
disp('MLP')
err = svmsa(trn(:, 1:trn_c - 1), trn(:, trn_c), ...
    tst(:, 1:tst_c - 1), tst(:, tst_c),  'mlp');
err