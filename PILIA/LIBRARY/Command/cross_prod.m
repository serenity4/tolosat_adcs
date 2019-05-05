function w=cross_prod(u, v)
% Cross product of the 3D vectors u and v
    w=[u(2)*v(3)-u(3)*v(2);v(1)*u(3)-v(3)*u(1);u(1)*v(2)-v(1)*u(2)];
end