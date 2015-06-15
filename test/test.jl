# John Eargle (mailto: jeargle at gmail.com)
# 2015
# test

using Quasispecies

Q = [0.8 0.1 0.1;
     0.1 0.8 0.1;
     0.1 0.1 0.8]
# Q = [0.9 0.05 0.05;
#      0.05 0.9 0.05;
#      0.05 0.05 0.9]
# f = [1.0, 1.0, 1.0]
# f = [0.5, 0.3, 0.2]
# f = [1.5, 1.3, 1.2]
# f = [0.3, 0.5, 0.2]
f = [1.5, 1.0, 0.5]
x = [0.1, 0.1, 0.8]
t = 0.2

printsummary(x)

for i = 1:20
    xp = quasispecies(x, Q, f)
    # printsummary(xp)
    # println("sum(xp): ", sum(xp))
    x = x + t*(x.*xp)
    x = x/norm(x, 1)
    printsummary(x)
    # println("sum(x): ", sum(x))
end
