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
x1 =  [0.1, 0.1, 0.8]
x2 =  [0.1, 0.2, 0.7]
x3 =  [0.1, 0.3, 0.6]
x4 =  [0.1, 0.4, 0.5]
x5 =  [0.1, 0.5, 0.4]
x6 =  [0.1, 0.8, 0.1]
x7 =  [0.2, 0.7, 0.1]
x8 =  [0.3, 0.6, 0.1]
x9 =  [0.4, 0.5, 0.1]
x10 = [0.5, 0.4, 0.1]
x11 = [0.8, 0.1, 0.1]
x12 = [0.7, 0.1, 0.2]
x13 = [0.6, 0.1, 0.3]
x14 = [0.5, 0.1, 0.4]
x15 = [0.4, 0.1, 0.5]
starts = [x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15]

numsteps = 200
timestep = 0.2        # timestep

# Run quasispecies simulation
println("\n*** simulate 1 ***\n")
trajList = Array{Float64,2}[]
for i = 1:size(starts,2)
    print(starts[:,i])
    push!(trajList, simulate(starts[:,i], Q1, f1, numsteps, timestep))
end
print(trajList[1])

println("")
println("*** cartesian coords ***")

# Get Cartesian coords
cartCoords = zeros(Float64, size(trajList,1), size(trajList[1],1), 2)
for i = 1:size(trajList,1)
    for j = 1:size(trajList[1],1)
        cartCoords[i,j,:] = bary2cart(vec(trajList[i][j,:]))
    end
end

println("")
println("*** set 1 ***")

for i = 1:size(cartCoords,2)
    println(vec(cartCoords[1,i,:]))
end


draw(SVG("myplot.svg", 6inch, 6inch),
     plot([layer(x=cartCoords[i,:, 1],
                 y=cartCoords[i,:, 2],
                 Geom.line(preserve_order=false)
                 )
           for i = 1:size(cartCoords,1)]...,
          layer(x=[0.0, 1.0, 0.5, 0.0],
                y=[0.0, 0.0, sqrt(3.0)/2, 0.0],
                Geom.line(preserve_order=false),
                Theme(default_color=colorant"black")
                ),
          Scale.x_continuous(minvalue=0.0, maxvalue=1.0),
          Scale.y_continuous(minvalue=0.0, maxvalue=1.0)
          ),
     )
