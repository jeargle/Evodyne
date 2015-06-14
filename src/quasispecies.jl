# John Eargle (mailto: jeargle at gmail.com)
# 2015
# quasispecies

# dx_i/dt = sum_{j=0 to n} q_ij*f_j*x_j - phi*x_i = Q.*f*x - phi*x = W*x - phi*x
# x_i: fraction of infinite population as quasispecies i
# sum(x) = 1.0
# sum(dx/dt) = 0.0
# f_i: fitness of quasispecies i
# phi = dot(x, f)
# Q = [q_ij]: mutation matrix
# W = [w_ij] = Q.*f: mutation-selection matrix

function printsummary(a)
    # summary generates a summary of an object
    println(summary(a), ":\n", repr(a))
end


# rate of change for x
function quasispecies(x, Q, f)
    phi = dot(f, x)
    println("  phi: ", phi)
    return Q*(f.*x) - phi*x
end

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
