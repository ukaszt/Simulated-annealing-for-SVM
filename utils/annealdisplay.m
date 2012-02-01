function [stop,options,optchanged] = annealdisplay(options,optimvalues,flag)
%ANNEALDISPLAY Summary of this function goes here
%   Detailed explanation goes here
    fprintf('Current point i = %d value = %d temperature = %d \n', optimvalues.x, optimvalues.fval, optimvalues.temperature);
    
    stop = false;
    optchanged = false;

end

