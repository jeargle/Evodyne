# John Eargle (mailto: jeargle at gmail.com)
# 2015-2020
# quasispecies


module Quasispecies

using LinearAlgebra
using Printf

export print_summary, print_matrix
export rock_paper_scissors, hawk_dove, chicken, snowdrift
export quasispecies, bary2cart, simulate


# =======================================
# General form for quasispecies simulations
# =======================================

# dx_i/dt = sum_{j=0 to n} q_ij*f_j*x_j - phi*x_i = Q.*f*x - phi*x = W*x - phi*x
# x_i: fraction of infinite population as quasispecies i
# sum(x) = 1.0
# sum(dx/dt) = 0.0
# f_i: fitness of quasispecies i
# phi = dot(x, f)
# Q = [q_ij]: mutation matrix
# W = [w_ij] = Q.*f: mutation-selection matrix


# =======================================
# Reporting
# =======================================

"""
    print_summary(a)

Print the summary for an object a.
"""
function print_summary(a)
    # summary generates a summary of an object
    println(summary(a), ":\n", repr(a))
end


"""
    print_matrix(a)

Print the matrix a.
"""
function print_matrix(a)
    x = size(a, 1)
    y = size(a, 2)
    for i = 1:x
        for j = 1:y
            @printf "%4.3f " a[i,j]
        end
        print("\n")
    end
end


"""
    bitdiff(b1, b2)

Get the number of bits different between two bitstrings.
"""
function bitdiff(b1, b2)
    length([x for x in eachmatch(r"1", bitstring((b1|b2)&~(b1&b2)))])
end


"""
    rock_paper_scissors(b, c)

Build a replicator fitness function for Rock Paper Scissors.

# Arguments
- b benefit of winning fight
- c cost of losing fight
"""
function rock_paper_scissors(b=1.0, c=1.0)
    # a: rock-paper-scissors game theoretic payoff matrix
    # x: species frequency vector
    a = [0.0  -c   b;
           b 0.0  -c;
          -c   b 0.0]
    return x -> a*x
end


"""
    hawk_dove(b, c)

Build a replicator fitness function for the Hawk-Dove game.

# Arguments
- b benefit of winning fight
- c cost of losing fight
"""
function hawk_dove(b, c)
    # a: hawk-dove game theoretic payoff matrix
    # x: species frequency vector
    a = [(b-c)/2 b;
         0.0 b/2]
    return x -> a*x
end


"""
    chicken(b, c)

Build a replicator fitness function for the Chicken game.

# Arguments
- b benefit of winning fight
- c cost of losing fight
"""
function chicken(b, c)
    # a: chicken game theoretic payoff matrix
    # x: species frequency vector
    a = [-c b;
         0.0 b/2]
    return x -> a*x
end


"""
    snowdrift(b, c)

Build a replicator fitness function for the Snowdrift game.

# Arguments
- b benefit of winning fight
- c cost of losing fight
"""
function snowdrift(b, c)
    # a: snowdrift game theoretic payoff matrix
    # x: species frequency vector
    a = [(b-c/2) (b-c);
         b 0.0]
    return x -> a*x
end


"""
    quasispecies(len, mutProb)

Generate a quasispecies mutation matrix.

# Arguments
- len::Int number of binary characters in the genome
- mutProb::Float64 probability of a single SNP
"""
function quasispecies(len::Int, mutProb::Float64)
    bitslen = 2^len
    Q = zeros(Float64, bitslen, bitslen)
    genomes = collect(0x0:convert(UInt,bitslen-1))
    for i = 1:bitslen
        for j = i+1:bitslen
            diffbits = bitdiff(genomes[i], genomes[j])
            prob = mutProb^diffbits
            Q[i,j] = prob
            Q[j,i] = prob
        end
    end

    remainder = 1.0 - sum(Q[:,1])
    for i = 1:bitslen
        Q[i,i] = remainder
    end

    return Q
end


"""
    bary2cart(r)

Transform from barycentric to Cartesian coordinates.
"""
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
    return [coord[1] coord[2]]
end

function bary2cart(r1, r2, r3)
    bary2cart([r1, r2, r3])
end


"""
    replicatorMutator(x, Q, f)

Quasispecies equation (replicator/mutator) rate of change for x

# Arguments
- x population vector
- Q mutation matrix
- f fitness vector
"""
function replicatorMutator(x::Array{T,1}, Q::Array{T,2}, f::Array{T,1}) where T<:Float64
    phi = dot(f, x)
    println("  phi: ", phi)
    return Q*(f.*x) - phi*x
end


"""
    replicator(x, f)

Replicator equation (no mutation)

# Arguments
- x quasispecies population vector
- f fitness vector
"""
function replicator(x::Array{T,1}, f::Array{T,1}) where T<:Float64
    phi = dot(f, x)
    println("  phi: ", phi)
    return f.*x - phi*x
end



# =======================================
# Simulation functions for different scenarios
# =======================================

"""
    simulate(x, Q, f, numsteps, timestep)

Replicator/mutator simulation with fitness vector.

# Arguments
- x population vector
- Q mutation matrix
- f fitness vector
- numsteps number of steps to simulate
- timestep time for a single step
"""
function simulate(x::Array{T,1}, Q::Array{T,2}, f::Array{T,1}, numsteps, timestep::T=1.0) where T<:Float64
    traj = zeros(Float64, numsteps+1, size(x,1))
    traj[1,:] = x
    for i = 1:numsteps
        xp = replicatorMutator(x, Q, f)
        x = x + timestep*(x.*xp)
        x = x/norm(x, 1)
        # print_summary(x)
        traj[i+1,:] = x
    end
    return traj
end


"""
    simulate(x, Q, f, numsteps, timestep)

Replicator/mutator simulation with fitness function.

# Arguments
- x population vector
- Q mutation matrix
- f function of x that returns fitness vector
- numsteps number of steps to simulate
- timestep time for a single step
"""
function simulate(x::Array{T,1}, Q::Array{T,2}, f::Function, numsteps, timestep::T=1.0) where T<:Float64
    traj = zeros(Float64, numsteps+1, size(x,1))
    traj[1,:] = x
    for i = 1:numsteps
        xp = replicatorMutator(x, Q, f(x))
        x = x + timestep*(x.*xp)
        x = x/norm(x, 1)
        print_summary(x)
        traj[i+1,:] = x
    end
    return traj
end


"""
    simulate(x, f, numsteps, timestep)

Replicator simulation with fitness vector.

# Arguments
- x population vector
- f fitness vector
- numsteps number of steps to simulate
- timestep time for a single step
"""
function simulate(x::Array{T,1}, f::Array{T,1}, numsteps, timestep::T=1.0) where T<:Float64
    traj = zeros(Float64, numsteps+1, size(x,1))
    traj[1,:] = x
    for i = 1:numsteps
        xp = replicator(x, f)
        x = x + timestep*(x.*xp)
        x = x/norm(x, 1)
        print_summary(x)
        traj[i+1,:] = x
    end
    return traj
end


"""
    simulate(x, f, numsteps, timestep)

Replicator simulation with fitness function.

# Arguments
- x population vector
- f function of x that returns fitness vector
- numsteps number of steps to simulate
- timestep time for a single step
"""
function simulate(x::Array{T,1}, f::Function, numsteps, timestep::T=1.0) where T<:Float64
    traj = zeros(Float64, numsteps+1, size(x,1))
    traj[1,:] = x
    for i = 1:numsteps
        xp = replicator(x, f(x))
        x = x + timestep*(x.*xp)
        x = x/norm(x, 1)
        print_summary(x)
        traj[i+1,:] = x
    end
    return traj
end

end
