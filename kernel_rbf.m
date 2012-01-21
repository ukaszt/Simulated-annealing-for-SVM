function k = kernel_rbf(u, v, sigma)
    u
    v
    k = exp(-sigma*norm(v-u)^2);