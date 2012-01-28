warning off

times = [60 60 60 60 60 60]

gloresult = zeros(1, 4);

disp('FSA POLYNOMIAL 3')
res = wmh_solve_time('polynomial3', times(1), @annealingfast)
gloresult = vertcat(gloresult, res);

%2
disp('BOLTZ POLYNOMIAL 3')
res = wmh_solve_time('polynomial3', times(2), @annealingboltz)
gloresult = vertcat(gloresult, res);

%3
disp('FSA POLYNOMIAL 2')
res = wmh_solve_time('polynomial2', times(3), @annealingfast)
gloresult = vertcat(gloresult, res);

%4
disp('BOLTZ POLYNOMIAL 2')
res = wmh_solve_time('polynomial2', times(4), @annealingboltz)
gloresult = vertcat(gloresult, res);

%5
disp('FSA TANH')
res = wmh_solve_time('tanh', times(5), @annealingfast)
gloresult = vertcat(gloresult, res);

%6
disp('BOLTZ TANH')
res = wmh_solve_time('tanh', times(6), @annealingboltz)
gloresult = vertcat(gloresult, res);

gloresult
dlmwrite('gloresult.csv', gloresult, 'delimiter', ',');