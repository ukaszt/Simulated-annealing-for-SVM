function k = kernel_rbf(u, v, sigma)
    [r1, c1] = size(u);
    [r2, c2] = size(v);
   
    vr = v;
    
    if r1 ~= r2
        vr = repmat(v, r1, 1);
    end
    
    u
    vr
    
    k = exp(-sigma*norm(vr-u)^2);