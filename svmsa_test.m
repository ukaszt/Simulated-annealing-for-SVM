function y=svmsa_test()
    trnd = [
    0 5
    0 4
    5 0
    4 0
    5 5
    4 4
    ];
    trng = [1; 1; 2; 2; 3; 3];

    tstd = [
    0 5
    0 4
    5 0
    4 0
    5 5
    4 4
    ];
    tstg = [1; 1; 2; 2; 3; 3];
    
    err_num = svmsa(trnd, trng, tstd, tstg, @(u,v) kernel_tanh(u, v, 1, 2));
    disp (err_num)

    