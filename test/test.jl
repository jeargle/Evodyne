# John Eargle (mailto: jeargle at gmail.com)
# 2015-2021
# test
#
# To build sysimage boom.so from uveldt/test:
#   using PackageCompiler
#   create_sysimage([:LinearAlgebra, :Plots, :Printf], sysimage_path="../boom.so", precompile_execution_file="so_builder.jl")
#
# To run from uveldt/test:
#   julia --project=.. -J../boom.so test.jl

using Plots

using Evodyne


function print_test_header(test_name)
    border = repeat("*", length(test_name) + 4)
    println()
    println(border)
    println("* ", test_name, " *")
    println(border)
end

function f2(x::Array{Float64,1})
    # Game theoretic payoff matrix
    a = [0.8 0.1;
         0.1 0.8]
    return a*x
end

function f2new(a)
    # a: game theoretic payoff matrix
    # x: species frequency vector
    return x -> a*x
end

function test_simulate()
    # Run quasispecies simulation
    print_test_header("Simulate Different Scenarios")

    # Quasispecies mutation matrix columns and rows must sum to 1
    # Q1 = [0.9 0.05 0.05;
    #       0.05 0.9 0.05;
    #       0.05 0.05 0.9]
    Q1 = [0.8 0.1 0.1;
          0.1 0.8 0.1;
          0.1 0.1 0.8]
    Q2 = [0.8 0.1;
          0.1 0.8]

    timestep = 0.2
    numsteps = 10

    # x must sum to 1
    x1 = [0.1, 0.1, 0.8]
    x2 = [0.1, 0.9]

    println("*** print arrays ***")
    # print_summary(x1)
    # print_summary(x2)
    print_matrix(x1)
    print_matrix(x2)

    # f elements must be non-negative
    # f = [1.0, 1.0, 1.0]
    # f = [0.5, 0.3, 0.2]
    # f = [1.5, 1.3, 1.2]
    # f = [0.3, 0.5, 0.2]
    f1 = [1.5, 1.0, 0.5]

    println("\n*** simulate 1 ***")
    simulate(x1, Q1, f1, numsteps, timestep)

    println("\n*** simulate 2 ***")
    simulate(x1, f1, numsteps, timestep)

    println("\n*** simulate 3 ***")
    simulate(x2, Q2, f2, numsteps, timestep)

    println("\n*** simulate 4 ***")
    a = [0.8 0.1;
         0.1 0.8]
    simulate(x2, f2new(a), numsteps, timestep)
end

function test_rock_paper_scissors()
    print_test_header("Simulate Rock-Paper-Scissors Scenarios")

    timestep = 0.2
    numsteps = 20

    # x must sum to 1
    x1 = [0.7, 0.2, 0.1]
    x2 = [0.2, 0.1, 0.7]
    x3 = [0.1, 0.7, 0.2]

    println("*** print species arrays ***")
    print_matrix(x1)
    print_matrix(x2)
    print_matrix(x3)

    rps1 = rock_paper_scissors()

    println("\n*** simulate 1 ***")
    simulate(x1, rps1, numsteps, timestep)

    println("\n*** simulate 2 ***")
    simulate(x2, rps1, numsteps, timestep)

    println("\n*** simulate 3 ***")
    simulate(x3, rps1, numsteps, timestep)
end

function test_hawk_dove()
    print_test_header("Simulate Hawk-Dove Scenarios")

    timestep = 0.2
    numsteps = 20

    # x must sum to 1
    x1 = [0.8, 0.2]
    x2 = [0.2, 0.8]
    x3 = [0.5, 0.5]

    println("*** print species arrays ***")
    # print_summary(x1)
    print_matrix(x1)
    print_matrix(x2)
    print_matrix(x3)

    hd1 = hawk_dove(2, 1)
    hd2 = hawk_dove(1, 5)

    println("\n*** simulate 1 ***")
    simulate(x1, hd1, numsteps, timestep)

    println("\n*** simulate 2 ***")
    simulate(x1, hd2, numsteps, timestep)

    println("\n*** simulate 3 ***")
    simulate(x2, hd1, numsteps, timestep)

    println("\n*** simulate 4 ***")
    simulate(x2, hd2, numsteps, timestep)

    println("\n*** simulate 5 ***")
    simulate(x3, hd1, numsteps, timestep)

    println("\n*** simulate 6 ***")
    simulate(x3, hd2, numsteps, timestep)
end

function test_chicken()
    print_test_header("Simulate Chicken Scenarios")

    timestep = 0.2
    numsteps = 20

    # x must sum to 1
    x1 = [0.8, 0.2]
    x2 = [0.2, 0.8]
    x3 = [0.5, 0.5]

    println("*** print species arrays ***")
    print_matrix(x1)
    print_matrix(x2)
    print_matrix(x3)

    c1 = chicken(2, 1)
    c2 = chicken(1, 5)

    println("\n*** simulate 1 ***")
    simulate(x1, c1, numsteps, timestep)

    println("\n*** simulate 2 ***")
    simulate(x1, c2, numsteps, timestep)

    println("\n*** simulate 3 ***")
    simulate(x2, c1, numsteps, timestep)

    println("\n*** simulate 4 ***")
    simulate(x2, c2, numsteps, timestep)

    println("\n*** simulate 5 ***")
    simulate(x3, c1, numsteps, timestep)

    println("\n*** simulate 6 ***")
    simulate(x3, c2, numsteps, timestep)
end

function test_snowdrift()
    print_test_header("Simulate Snowdrift Scenarios")

    timestep = 0.2
    numsteps = 20

    # x must sum to 1
    x1 = [0.8, 0.2]
    x2 = [0.2, 0.8]
    x3 = [0.5, 0.5]

    println("*** print species arrays ***")
    print_matrix(x1)
    print_matrix(x2)
    print_matrix(x3)

    s1 = snowdrift(2, 1)
    s2 = snowdrift(1, 5)

    println("\n*** simulate 1 ***")
    simulate(x1, s1, numsteps, timestep)

    println("\n*** simulate 2 ***")
    simulate(x1, s2, numsteps, timestep)

    println("\n*** simulate 3 ***")
    simulate(x2, s1, numsteps, timestep)

    println("\n*** simulate 4 ***")
    simulate(x2, s2, numsteps, timestep)

    println("\n*** simulate 5 ***")
    simulate(x3, s1, numsteps, timestep)

    println("\n*** simulate 6 ***")
    simulate(x3, s2, numsteps, timestep)
end

function print_bary2cart(r1, r2, r3)
    cartCoord = bary2cart(r1, r2, r3)
    println("(", r1, ", ", r2, ", ", r3, ") -> (", cartCoord[1], ", ", cartCoord[2], ")")
end

function test_bary2cart()
    # Transform from barycentric to Cartesian coordinates
    print_test_header("Barycentric to Cartesian coordinates")

    print_bary2cart(0.5, 0.4, 0.1)
    print_bary2cart(1.0, 0.0, 0.0)
    print_bary2cart(0.0, 1.0, 0.0)
    print_bary2cart(0.0, 0.0, 1.0)
    print_bary2cart(1/3, 1/3, 1/3)
end

function test_plot_trajectories()
    # Transform from barycentric to Cartesian coordinates
    print_test_header("Plot simulated trajectories in barycentric coordinates")

    # Q columns and rows must sum to 1
    Q1 = [0.8 0.1 0.1;
          0.1 0.8 0.1;
          0.1 0.1 0.8]

    # f1 elements must be non-negative
    # f1 = [1.0, 1.0, 1.0]
    # f1 = [0.5, 0.3, 0.2]
    # f1 = [1.5, 1.3, 1.2]
    # f1 = [0.3, 0.5, 0.2]
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
    timestep = 0.2

    # Run quasispecies simulation
    trajList = Array{Float64,2}[]
    for i = 1:size(starts,2)
        push!(trajList, simulate(starts[:,i], Q1, f1, numsteps, timestep))
    end

    p = plot_trajectories(trajList)
    savefig(p, "myplot.svg")
end

function test_quasispecies()
    # Quasispecies mutation matrix builder
    print_test_header("Quasispecies matrices")

    Q1 = quasispecies(2, 0.1)
    Q2 = quasispecies(4, 0.1)

    print_matrix(Q1)
    print_matrix(Q2)
end


function main()
    test_bary2cart()
    test_simulate()
    test_rock_paper_scissors()
    test_hawk_dove()
    test_chicken()
    test_snowdrift()
    test_plot_trajectories()
    test_quasispecies()
end

main()
