function x = kernel_linear(u, v, p1)
    % The Linear kernel is the simplest kernel function. It is given by the
    % inner product <x,y> plus an optional constant p1.
    x = (u*v') + p1;  
end

