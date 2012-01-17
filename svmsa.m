function [ errorn ] = svmsa(trnd, trng, tstd, tstg, kernel)
    unqcls = unique([trng; tstg]);
    unqclsno = length(unqcls);
    
    trn    = [trnd trng];
    tstno  = size(tstd);
    newcls = zeros(tstno(2), unqclsno);
    
    % Traning classifiers
    if(unqclsno > 2)
        prs = nchoosek(unqcls, 2);
        itr=1;
        while(itr <= length(prs))
            clsa = trn(find(trn(:, end) == prs(itr, 1)), :); % wiersze danych trenujacych spelniajace warunke numeru klasy
            clsb = trn(find(trn(:, end) == prs(itr, 2)), :); % wiersze danych trenujacych spelniajace warunke numeru klasy
            svmclsfr = svmtrain([ clsa(:, 1:end-1); clsb(:, 1:end-1)], ...
                [clsa(:, end); clsb(:, end)], 'kernel_function', kernel, ... 
                'showplot', false, 'autoscale', false);
            
            itr2=1;
            while itr2 <= tstno(1)
                res = svmclassify(svmclsfr, tstd(itr2, :));
                newcls(itr2, find( unqcls == res)) = newcls(itr2, find( unqcls == res )) + 1;
                itr2=itr2 + 1;
            end            
            itr=itr+1;
        end
    end
    
    newcls
    
    % errorn = sum(~(svm_classify_result == tstg));
    % disp('NUM ERR:')
    % disp(errorn)
end

% a = magic(3)
% a(1, 3) = 2
% a(find( a(:,end) == 2 ), :)
