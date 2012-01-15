function wmh_solve()
    %anonymous fun for passing arguments
    %@(u,v) kfun(u,v,p1,p2)
    train = dlmread('train.txt');
    test  = dlmread('test.txt');
    
    p0 = [1 1];
    min_fun = @(p) svmsa(train, test,  @(u, v) kernel_tanh(u, v, p(1), p(2)));
    [x, fval, exitFlag, output] = simulaatedannealbnd(min_fun, p0);