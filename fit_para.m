function[a,b,c,d,e] = fit_para(x, y)

A = [(x').^4, (x').^3, (x').^2, x', ones(length(x),1)];
p = A\(y');
a = p(1);
b = p(2);
c = p(3);
d = p(4);
e = p(5);


