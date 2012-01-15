function [ errorn ] = svmsa(trnd, trng, tstd, tstg, kernel)

    svm_classfier = svmtrain(trnd, trng, 'kernel_function', kernel, 'autoscale', false);
    svm_classify_result = svmclassify(svm_classfier, tstd);
    
    errorn = sum(~(svm_classify_result == tstg));
end