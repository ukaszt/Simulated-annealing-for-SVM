function k = kernel_polynomial(u, v, a, c, d)
% The Polynomial kernel is a non-stationary kernel. Polynomial kernels are 
% well suited for problems where all the training data is normalized.
% k(x, y) = (\alpha x^T y + c)^d  
% Adjustable parameters are the slope alpha, the constant term c and the 
% polynomial degree d. 
    k = ((a*(u*v'))+c).^d;
end

