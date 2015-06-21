# John Eargle (mailto: jeargle at gmail.com)
# 2015
# quasispecies

module Quasispecies

export printsummary, quasispecies, bary2cart, simulate

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


# Generate a quasispecies mutation matrix
# len: number of binary characters in the genome
# mutProb: probability of a single SNP
function quasispecies(len, mutProb)
    
end


# Transform from barycentric to Cartesian coordinates
function bary2cart(r::Array{Float64,1})
    # x1 = 0.0
    # x2 = 0.5
    # x3 = 1.0
    # y1 = 0.0
    # y2 = sqrt(3)/2
    # y3 = 0.0
    T = [0.0 0.5 1.0;
         0.0 sqrt(3)/2 0.0]
    # x = r1*x1 + r2*x2 + r3*x3
    # y = r1*y1 + r2*y2 + r3*y3
    coord = T*r
    return coord[1], coord[2]
end

function bary2cart(r1, r2, r3)
    bary2cart([r1, r2, r3])
end


# Quasispecies equation (replicator/mutator)
# rate of change for x
# x: population vector
# Q: mutation matrix
# f: fitness vector
function replicatorMutator{T<:Float64}(x::Array{T,1}, Q::Array{T,2}, f::Array{T,1})
    phi = dot(f, x)
    println("  phi: ", phi)
    return Q*(f.*x) - phi*x
end

# Replicator equation
# x: quasispecies population vector
# f: fitness vector
function replicator{T<:Float64}(x::Array{T,1}, f::Array{T,1})
    phi = dot(f, x)
    println("  phi: ", phi)
    return f.*x - phi*x
end


# x: population vector
# Q: mutation matrix
# f: fitness vector
function simulate{T<:Float64}(x::Array{T,1}, Q::Array{T,2}, f::Array{T,1}, numsteps, timestep::T=1.0)
    for i = 1:numsteps
        xp = replicatorMutator(x, Q, f)
        x = x + timestep*(x.*xp)
        x = x/norm(x, 1)
        printsummary(x)
    end
end

# x: population vector
# Q: mutation matrix
# f: function of x that returns fitness vector
function simulate{T<:Float64}(x::Array{T,1}, Q::Array{T,2}, f::Function, numsteps, timestep::T=1.0)
    for i = 1:numsteps
        xp = replicatorMutator(x, Q, f(x))
        x = x + timestep*(x.*xp)
        x = x/norm(x, 1)
        printsummary(x)
    end
end

# x: population vector
# f: fitness vector
function simulate{T<:Float64}(x::Array{T,1}, f::Array{T,1}, numsteps, timestep::T=1.0)
    for i = 1:numsteps
        xp = replicator(x, f)
        x = x + timestep*(x.*xp)
        x = x/norm(x, 1)
        printsummary(x)
    end
end

# x: population vector
# f: function of x that returns fitness vector
function simulate{T<:Float64}(x::Array{T,1}, f::Function, numsteps, timestep::T=1.0)
    for i = 1:numsteps
        xp = replicator(x, f(x))
        x = x + timestep*(x.*xp)
        x = x/norm(x, 1)
        printsummary(x)
    end
end

end
