function [ errorn ] = svmsa(train, test, kernel)
%SVM-SA Summary of this function goes here
%   Detailed explanation goes here
    
    [r1, c1] = size(train);
    [r2, c2] = size(test);

    train_data = train(1:r1, 1:c1-1);
    train_grps = train(1:r1, c1);
    
    test_data = test(1:r2, 1:c2-1);
    test_grps = test(1:r2, c2);     
    
    svm_classfier = svmtrain(train_data, train_grps, 'kernel_function', kernel, 'showplot', true);
    hold on
    svm_classify_result = svmclassify(svm_classfier, test_data, 'showplot', true);

    errorn = sum(~(svm_classify_result == test_grps));
end