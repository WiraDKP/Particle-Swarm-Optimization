function out = problemfunc(x, rosbr)
    a = rosbr.a; b = rosbr.b;
    out = (a-x(1)).^2 + b*(x(2)-x(1).^2).^2;
end

