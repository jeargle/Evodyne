# John Eargle (mailto: jeargle at gmail.com)
# 2015-2017
# test

using Quasispecies


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
    println()
    println("***")
    println("*** Simulate Different Scenarios ***")
    println("***")
    println()
    
    # Quasispecies mutation matrix columns and rows must sum to 1
    # Q1 = [0.9 0.05 0.05;
    #       0.05 0.9 0.05;
    #       0.05 0.05 0.9]
    Q1 = [0.8 0.1 0.1;
          0.1 0.8 0.1;
          0.1 0.1 0.8]
    Q2 = [0.8 0.1;
          0.1 0.8]
    
    timestep = 0.2        # timestep
    numsteps = 10
    
    # x must sum to 1
    x1 = [0.1, 0.1, 0.8]
    x2 = [0.1, 0.9]

    println("*** print arrays ***")
    # printsummary(x1)
    # printsummary(x2)
    printmatrix(x1)
    printmatrix(x2)

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

function test_hawk_dove()
    println()
    println("***")
    println("*** Simulate Hawk-Dove Scenarios ***")
    println("***")
    println()
    
    timestep = 0.2        # timestep
    numsteps = 20
    
    # x must sum to 1
    x1 = [0.8, 0.2]
    x2 = [0.2, 0.8]
    x3 = [0.5, 0.5]

    println("*** print species arrays ***")
    # printsummary(x1)
    printmatrix(x1)
    printmatrix(x2)
    printmatrix(x3)

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

function print_bary2cart(r1, r2, r3)
    cartCoord = bary2cart(r1, r2, r3)
    println("(", r1, ", ", r2, ", ", r3, ") -> (", cartCoord[1], ", ", cartCoord[2], ")")
end

function test_bary2cart()
    # Transform from barycentric to Cartesian coordinates
    println()
    println("***")
    println("*** barycentric to Cartesian coordinates ***")
    println("***")
    println()
    print_bary2cart(0.5, 0.4, 0.1)
    print_bary2cart(1.0, 0.0, 0.0)
    print_bary2cart(0.0, 1.0, 0.0)
    print_bary2cart(0.0, 0.0, 1.0)
    print_bary2cart(1/3, 1/3, 1/3)
end

function test_quasispecies()
    # Quasispecies mutation matrix builder
    println()
    println("***")
    println("*** Quasispecies matrices ***")
    println("***")
    println()
    Q1 = quasispecies(2, 0.1)
    Q2 = quasispecies(4, 0.1)
    
    printmatrix(Q1)
    printmatrix(Q2)
end


function main()
    # test_bary2cart()
    # test_simulate()
    test_hawk_dove()
    # test_quasispecies()
end

main()
