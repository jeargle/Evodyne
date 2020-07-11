using Plots
using Printf

println()
@printf "PackageCompiler so Builder\n"

plotly()
display(plot(
             [sin, cos, x->-sin(x), x->-cos(x)],
             [0:0.2:20],
             title = "Four Lines",
             label = ["Line 1" "Line 2" "Line 3" "Line 4"],
             linewidth = 3
             )
        )
