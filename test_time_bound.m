%warning off

times = [30 30 30 30 30 30]

gloresult = zeros(1, 4);

disp('FSA POLYNOMIAL 3')
gloresult = vertcat(gloresult, wmh_solve_time('polynomial3', times(1), @annealingfast));

%2
disp('BOLTZ POLYNOMIAL 3')
gloresult = vertcat(gloresult, wmh_solve_time('polynomial3', times(2), @annealingboltz));

%3
disp('FSA POLYNOMIAL 2')
gloresult = vertcat(gloresult, wmh_solve_time('polynomial2', times(3), @annealingfast));

%4
disp('BOLTZ POLYNOMIAL 2')
gloresult = vertcat(gloresult, wmh_solve_time('polynomial2', times(4), @annealingboltz));

%5
disp('FSA TANH')
gloresult = vertcat(gloresult, wmh_solve_time('tanh', times(5), @annealingfast));

%6
disp('BOLTZ TANH')
gloresult = vertcat(gloresult, wmh_solve_time('tanh', times(6), @annealingboltz));
