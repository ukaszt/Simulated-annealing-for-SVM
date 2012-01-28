function [ output_args ] = wmhsolver(trn, tst, varargin)

% defaults setup
cmethod = 'annealing';
kfun = 'poly3 ';
saopt = saoptimset('simulannealbnd');

numoptargs = nargin - 2;
optargs = varargin;

if  numoptargs >= 1
    okargs = {'method', 'kernel_function', 'variant'};
    
    for j=1:2:numoptargs
        pname = optargs{j};
        pval = optargs{j+1};
        k = find(strcmpi(pname, okargs));
        
        if isempty(k)
            error('WMH:wmhsolver', 'Unknown parameter name: %s.',pname);
        else
            switch(k)
                case 1 % method
                    if strcmpi(pval, 'full')
                        cmethod = 'full';
                    else
                        cmethod = 'annealing';
                    end
                    
                case 2 % kernel_function
                    okfuns = { 'poly2', 'poly3', 'rbf', 'tan', 'linear'};
                    funNum = strmatch(lower(pval), okfuns);
                    if isempty(funNum)
                        error('WMH:wmhsolver', ... 
                                'Unknown kernel function');
                    else
                        kfun = pval;
                    end
                case 3 % variant
                    if ischar(pval)
                        okvariants = { 'boltz', 'fast' }
                        varNum = strmatch(lower(pval), okvariants);
                        if isempty(varNum)
                            varNum = 0;
                        end
                        switch varNum
                            case 1
                                annealingFcn = @annealingboltz;
                                temperatureFcn = @temperatureboltz;
                            case 2
                                annealingFcn = @annealingfast;
                                temperatureFcn = @temperaturefast;
                            otherwise
                                error('WMH:wmhsolver', ...
                                    'Unknown annealing variant');
                        end
                        saopt = saoptimset('AnnealingFcn', annealingFcn, ...
                            'TemperatureFcn', temperatureFcn);
                    end
            end
        end

    end
end

if strcmpi(cmethod, 'annealing')
    annealing(trn, tst, kfun, saopt);
else
    disp('FULL')

end

