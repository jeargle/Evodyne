# John Eargle (mailto: jeargle at gmail.com)
# 2015
# quasispecies

module Quasispecies

export printsummary, quasispecies, simulate

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
# x: quasispecies population vector
# Q: mutation matrix
# f: fitness vector
function quasispecies{T<:Float64}(x::Array{T,1}, Q::Array{T,2}, f::Array{T,1})
    phi = dot(f, x)
    println("  phi: ", phi)
    return Q*(f.*x) - phi*x
end

# Replicator equation
# x: quasispecies population vector
# f: fitness vector
function quasispecies{T<:Float64}(x::Array{T,1}, f::Array{T,1})
    phi = dot(f, x)
    println("  phi: ", phi)
    return f.*x - phi*x
end

# Simulate quasispecies
# x: quasispecies population vector
# Q: mutation matrix
# a: game theoretic payoff matrix
function simulate{T<:Float64}(x::Array{T,1}, Q::Array{T,2}, a::Array{T,2}, numsteps, timestep::T=1.0)
    for i = 1:numsteps
        f = a*x
        xp = quasispecies(x, Q, f)
        x = x + timestep*(x.*xp)
        x = x/norm(x, 1)
        printsummary(x)
    end
end

# x: quasispecies population vector
# Q: mutation matrix
# f: fitness vector
function simulate{T<:Float64}(x::Array{T,1}, Q::Array{T,2}, f::Array{T,1}, numsteps, timestep::T=1.0)
    for i = 1:numsteps
        xp = quasispecies(x, Q, f)
        x = x + timestep*(x.*xp)
        x = x/norm(x, 1)
        printsummary(x)
    end
end

# x: quasispecies population vector
# f: fitness vector
function simulate{T<:Float64}(x::Array{T,1}, f::Array{T,1}, numsteps, timestep::T=1.0)
    for i = 1:numsteps
        xp = quasispecies(x, f)
        x = x + timestep*(x.*xp)
        x = x/norm(x, 1)
        printsummary(x)
    end
end

end
