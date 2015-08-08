# John Eargle (mailto: jeargle at gmail.com)
# 2015
# test

using Gadfly

using Quasispecies


# Q columns and rows must sum to 1
Q1 = [0.8 0.1 0.1;
      0.1 0.8 0.1;
      0.1 0.1 0.8]

# f elements must be non-negative
# f = [1.0, 1.0, 1.0]
# f = [0.5, 0.3, 0.2]
# f = [1.5, 1.3, 1.2]
# f = [0.3, 0.5, 0.2]
f1 = [1.5, 1.0, 0.5]

# x must sum to 1
x1 = [0.1, 0.1, 0.8]
x2 = [0.1, 0.3, 0.6]
x3 = [0.1, 0.5, 0.4]

numsteps = 500
timestep = 0.2        # timestep

# Run quasispecies simulation
println("\n*** simulate 1 ***\n")
traj1 = simulate(x1, Q1, f1, numsteps, timestep)
traj2 = simulate(x2, Q1, f1, numsteps, timestep)
traj3 = simulate(x3, Q1, f1, numsteps, timestep)
print(traj1)

println("")
println("*********")

cartCoords1 = zeros(Float64, size(traj1,1), 2)
cartCoords2 = zeros(Float64, size(traj1,1), 2)
cartCoords3 = zeros(Float64, size(traj1,1), 2)
for i = 1:size(traj1,1)
    println(traj1[i,:])
    cartCoords1[i,:] = bary2cart(vec(traj1[i,:]))
    cartCoords2[i,:] = bary2cart(vec(traj2[i,:]))
    cartCoords3[i,:] = bary2cart(vec(traj3[i,:]))
end

println("")
println("*********")

for i = 1:size(cartCoords1,1)
    println(cartCoords1[i,:])
end


# Get Cartesian coords

# plot()
draw(SVG("myplot.svg", 6inch, 6inch),
     plot(layer(x=cartCoords1[:, 1],
                y=cartCoords1[:, 2],
                Geom.line(preserve_order=false)
                ),
          layer(x=cartCoords2[:, 1],
                y=cartCoords2[:, 2],
                Geom.line(preserve_order=false)
                ),
          layer(x=cartCoords3[:, 1],
                y=cartCoords3[:, 2],
                Geom.line(preserve_order=false)
                ),
          Scale.x_continuous(minvalue=0.0, maxvalue=1.0),
          Scale.y_continuous(minvalue=0.0, maxvalue=1.0)
          ),
     )
