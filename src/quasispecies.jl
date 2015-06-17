# John Eargle (mailto: jeargle at gmail.com)
# 2015
# quasispecies

module Quasispecies

export printsummary, quasispecies

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


# Quasispecies equation (replicator/mutator)
# rate of change for x
function quasispecies{T<:Float64}(x::Array{T,1}, Q::Array{T,2}, f::Array{T,1})
    phi = dot(f, x)
    println("  phi: ", phi)
    return Q*(f.*x) - phi*x
end

# Replicator equation
function quasispecies{T<:Float64}(x::Array{T,1}, f::Array{T,1})
    phi = dot(f, x)
    println("  phi: ", phi)
    return f.*x - phi*x
end

end
