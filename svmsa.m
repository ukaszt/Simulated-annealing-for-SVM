function [ errorn ] = svmsa(trnd, trng, tstd, tstg, kernel)
    T=trnd
    C=tstg
    u=unique(C);
    N=length(u);
    if(N>2)
        disp('multi class problem');
        itr=1;
        classes=0;
        while((classes~=1)&&(itr<=length(u)))
            c1=(C==u(itr));
            newClass=c1;
            svm_classfier = svmtrain(T,newClass, 'kernel_function', kernel, 'showplot', true, 'autoscale', false);
            svm_classify_result = svmclassify(svm_classfier,tstd,'showplot',true);
            itr=itr+1;
        end
    %clc;
    itr=itr-1;
    disp(itr)
    end
    
    errorn = sum(~(svm_classify_result == tstg));
    disp('NUM ERR:')
    disp(errorn)
end