function k = kernel_tanh(u, v, p1, p2)
    k = tanh(p1*(u*v')+p2);