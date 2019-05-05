function Q=QuatProd(R, S)
% Returns the product of the quaternions R and S
    Rr=R(1);Ri=R(2:4);
    Sr=S(1);Si=S(2:4);
    Q=[Rr*Sr-Ri'*Si;Rr*Si+Sr*Ri+cross_prod(Ri,Si)];
end