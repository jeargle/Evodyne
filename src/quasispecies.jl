# John Eargle (mailto: jeargle at gmail.com)
# 2015
# quasispecies

module Quasispecies

export printsummary, printmatrix, quasispecies, bary2cart, simulate

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

function printmatrix(a)
    x = size(a, 1)
    y = size(a, 2)
    for i in [1:x]
        for j in [1:y]
            @printf "%4.3f " a[i,j]
        end
        print("\n")
    end
end


# Get the number of bits different between two bitstrings
function bitdiff(b1, b2)
    length(matchall(r"1", bits((b1|b2)&~(b1&b2))))
end


# Generate a quasispecies mutation matrix
# len: number of binary characters in the genome
# mutProb: probability of a single SNP
function quasispecies(len::Int, mutProb::Float64)
    bitslen = 2^len
    Q = zeros(Float64, bitslen, bitslen)
    genomes = [0x0:convert(Uint,bitslen-1)]
    for i in [1:bitslen]
        for j in [i+1:bitslen]
            diffbits = bitdiff(genomes[i], genomes[j])
            prob = mutProb^diffbits
            Q[i,j] = prob
            Q[j,i] = prob
        end
    end

    remainder = 1.0 - sum(Q[:,1])
    for i in [1:bitslen]
        Q[i,i] = remainder
    end
    
    return Q
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
    return [coord[1] coord[2]]
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
    traj = zeros(Float64, numsteps+1, size(x,1))
    traj[1,:] = x
    for i = 1:numsteps
        xp = replicatorMutator(x, Q, f)
        x = x + timestep*(x.*xp)
        x = x/norm(x, 1)
        # printsummary(x)
        traj[i+1,:] = x
    end
    return traj
end

# x: population vector
# Q: mutation matrix
# f: function of x that returns fitness vector
function simulate{T<:Float64}(x::Array{T,1}, Q::Array{T,2}, f::Function, numsteps, timestep::T=1.0)
    traj = zeros(Float64, numsteps+1, size(x,1))
    traj[1,:] = x
    for i = 1:numsteps
        xp = replicatorMutator(x, Q, f(x))
        x = x + timestep*(x.*xp)
        x = x/norm(x, 1)
        printsummary(x)
        traj[i+1,:] = x
    end
    return traj
end

# x: population vector
# f: fitness vector
function simulate{T<:Float64}(x::Array{T,1}, f::Array{T,1}, numsteps, timestep::T=1.0)
    traj = zeros(Float64, numsteps+1, size(x,1))
    traj[1,:] = x
    for i = 1:numsteps
        xp = replicator(x, f)
        x = x + timestep*(x.*xp)
        x = x/norm(x, 1)
        printsummary(x)
        traj[i+1,:] = x
    end
    return traj
end

# x: population vector
# f: function of x that returns fitness vector
function simulate{T<:Float64}(x::Array{T,1}, f::Function, numsteps, timestep::T=1.0)
    traj = zeros(Float64, numsteps+1, size(x,1))
    traj[1,:] = x
    for i = 1:numsteps
        xp = replicator(x, f(x))
        x = x + timestep*(x.*xp)
        x = x/norm(x, 1)
        printsummary(x)
        traj[i+1,:] = x
    end
    return traj
end

end
