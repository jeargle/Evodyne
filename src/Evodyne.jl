# John Eargle (mailto: jeargle at gmail.com)
# Evodyne


module Evodyne

using LinearAlgebra
using Plots
using Printf

# Quasispecies
include("quasispecies.jl")
export print_summary, print_matrix
export rock_paper_scissors, hawk_dove, chicken, snowdrift
export quasispecies, bary2cart, plot_trajectories, simulate

# Axelrod
include("axelrod.jl")
export markov_game_matrix, run_axelrod_tournament

end
