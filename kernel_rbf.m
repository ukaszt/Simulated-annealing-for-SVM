function k = kernel_rbf(u, v, sigma)
    k = exp(-sigma*norm(u-v)^2);