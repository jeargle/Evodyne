# John Eargle (mailto: jeargle at gmail.com)
# 2015
# test

using Quasispecies

# Q columns and rows must sum to 1
Q1 = [0.8 0.1 0.1;
      0.1 0.8 0.1;
      0.1 0.1 0.8]
Q2 = [0.8 0.1;
      0.1 0.8]
Q3 = [0.9 0.05 0.05;
      0.05 0.9 0.05;
      0.05 0.05 0.9]

# f elements must be non-negative
# f = [1.0, 1.0, 1.0]
# f = [0.5, 0.3, 0.2]
# f = [1.5, 1.3, 1.2]
# f = [0.3, 0.5, 0.2]
f1 = [1.5, 1.0, 0.5]

function f2(x::Array{Float64,1})
    # Game theoretic payoff matrix
    a = [0.8 0.1;
         0.1 0.8]
    return a*x
end

# x must sum to 1
x1 = [0.1, 0.1, 0.8]
x2 = [0.1, 0.9]

     
timestep = 0.2        # timestep
numsteps = 10

println("\n*** print arrays ***\n")
# printsummary(x1)
# printsummary(x2)
printmatrix(x1)
printmatrix(x2)

# Run quasispecies simulation
println("\n*** simulate 1 ***\n")
simulate(x1, Q1, f1, numsteps, timestep)
println("\n*** simulate 2 ***\n")
simulate(x1, f1, numsteps, timestep)
println("\n*** simulate 3 ***\n")
simulate(x2, Q2, f2, numsteps, timestep)
println("\n*** simulate 4 ***\n")
simulate(x2, f2, numsteps, timestep)

# Transform from barycentric to Cartesian coordinates
println("\n*** barycentric to Cartesian coordinates ***\n")
r1, r2, r3 = 0.5, 0.4, 0.1
x, y = bary2cart(r1, r2, r3)
println("(", r1, ", ", r2, ", ", r3, ") -> (", x, ", ", y, ")")
r1, r2, r3 = 1.0, 0.0, 0.0
x, y = bary2cart(r1, r2, r3)
println("(", r1, ", ", r2, ", ", r3, ") -> (", x, ", ", y, ")")
r1, r2, r3 = 0.0, 1.0, 0.0
x, y = bary2cart(r1, r2, r3)
println("(", r1, ", ", r2, ", ", r3, ") -> (", x, ", ", y, ")")
r1, r2, r3 = 0.0, 0.0, 1.0
x, y = bary2cart(r1, r2, r3)
println("(", r1, ", ", r2, ", ", r3, ") -> (", x, ", ", y, ")")
r1, r2, r3 = 1/3, 1/3, 1/3
x, y = bary2cart(r1, r2, r3)
println("(", r1, ", ", r2, ", ", r3, ") -> (", x, ", ", y, ")")

# Quasispecies mutation matrix builder
println("\n*** Quasispecies matrices ***\n")
Q3 = quasispecies(2, 0.1)
Q4 = quasispecies(4, 0.1)

printmatrix(Q3)
printmatrix(Q4)
