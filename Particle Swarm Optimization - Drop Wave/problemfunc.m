function out = problemfunc(x)
    out = -( 1 + cos(12.*sqrt(x(1).^2+x(2).^2)) ) ./ ((x(1).^2+x(2).^2)/2 + 2);
end

