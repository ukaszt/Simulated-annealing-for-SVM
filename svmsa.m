function [ errorn ] = svmsa(trnd, trng, tstd, tstg, kernel)
    unqcls = unique([trng; tstg]);
    unqclsno = length(unqcls);
    
    trn    = [trnd trng];
    tstno  = size(tstd);
    newcls = zeros(tstno(1), unqclsno); % macierz wynikowa przypisania
                                        % danych testowych do klasy
    
    if(unqclsno > 2)
        prs = nchoosek(unqcls, 2); %all combinations of pairs of classes
        itr=1;
        while(itr <= length(prs))
            clsa = trn(find(trn(:, end) == prs(itr, 1)), :); % wiersze danych trenujacych nalezace
            clsb = trn(find(trn(:, end) == prs(itr, 2)), :); % do jednej z aktualnie sprawdzanych klas
            svmclsfr = svmtrain([ clsa(:, 1:end-1); clsb(:, 1:end-1)], ...
                [clsa(:, end); clsb(:, end)], 'kernel_function', kernel, ... 
                'showplot', false, 'autoscale', false);
            
            itr2=1;
            while itr2 <= tstno(1)
                res = svmclassify(svmclsfr, tstd(itr2, :));
                newcls(itr2, find(unqcls == res)) = newcls(itr2, find( unqcls == res )) + 1;
                itr2 = itr2+1;
            end            
            itr=itr+1;
        end
    end
    
    [maxvals, fincls] = max(newcls, [], 2); %fincls zawiera wynik przydzialu do klas
    
    errorn = sum(~(fincls == tstg));
end
