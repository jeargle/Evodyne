using LinearAlgebra
using Plots
using Printf

println()
@printf "PackageCompiler so Builder\n"

x = [1.1 2.2 3.3 4.4]
y = [2 4 6 8]
x_len = dot(x, x)
y_len = dot(y, y)
z = dot(x, y)

@printf "x length: %4.3f\n" x_len
@printf "y length: %d\n" y_len
@printf "dot(x, y): %4.3f\n" z

plotly()
# pyplot()
display(plot(
             [sin, cos, x->-sin(x), x->-cos(x)],
             [0:0.2:20],
             title = "Four Lines",
             label = ["Line 1" "Line 2" "Line 3" "Line 4"],
             linewidth = 3
             )
        )
