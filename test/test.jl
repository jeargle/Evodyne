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

# x must sum to 1
x1 = [0.1, 0.1, 0.8]
x2 = [0.1, 0.9]

a1 = [0.8 0.1;
      0.1 0.8]
     
timestep = 0.2        # timestep
numsteps = 20

printsummary(x1)
printsummary(x2)

# Run quasispecies simulation
simulate(x1, Q1, f1, numsteps, timestep)
simulate(x1, f1, numsteps, timestep)
simulate(x2, Q2, a1, numsteps, timestep)
# for i = 1:numsteps
#     xp = quasispecies(x, Q, f)
#     x = x + t*(x.*xp)
#     x = x/norm(x, 1)
#     printsummary(x)
# end
