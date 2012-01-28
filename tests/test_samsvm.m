disp('FSA POLYNOMIAL 3 300')
wmh_solve('polynomial3', 300, @annealingfast)

disp('BOLTZ POLYNOMIAL 3 300')
wmh_solve('polynomial3', 300, @annealingboltz)

disp('FSA POLYNOMIAL 2 300')
wmh_solve('polynomial2', 300, @annealingfast)

disp('BOLTZ POLYNOMIAL 2 300')
wmh_solve('polynomial2', 300, @annealingboltz)

disp('FSA TANH 300')
wmh_solve('tanh', 300, @annealingfast)

disp('BOLTZ TANH 300')
wmh_solve('tanh', 300, @annealingboltz)

