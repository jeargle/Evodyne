# John Eargle (mailto: jeargle at gmail.com)
# Evodyne.axelrod

"""
    markov_game_matrix(; )

Generate a Markov game matrix.

# Arguments
- `tt`: reward if both players choose true (true-true)
- `tf`: reward if player1 chooses true and player2 chooses false (true-false)
- `ft`: reward if player1 chooses false and player2 chooses true (false-true)
- `ff`: reward if both players choose false (false-false)

# Returns
- Markov game matrix
"""
function markov_game_matrix(; tt=0.0, tf=0.0, ft=0.0, ff=0.0)
    M = [tt tf;
         ft ff]

    return M
end


"""
    round_choice(player)

true/false choice made by a player in an Axelrod match round.

# Arguments
- `player`: player making the choice

# Returns
- `Bool`:
"""
function round_choice(player)
    return true
end


"""
    run_axelrod_match()

Run an Axelrod match between two competitors.

# Arguments
- `player1`: first player
- `player2`: second player
- `game_matrix`: Markov game matrix
- `num_rounds`: number of rounds in the match

# Returns
- win/loss record and final score
"""
function run_axelrod_match(player1, player2, game_matrix, num_rounds)
    match_result = []

    for i=1:num_rounds
        choice1 = round_choice(player1)
        choice2 = round_choice(player2)
    end

    return match_result
end


"""
    run_axelrod_tournament()

Run an Axelrod tournament where pairs of competitors compete against each other.

# Arguments

# Returns
"""
function run_axelrod_tournament(players, game_matrix, num_rounds)
    num_players = length(players)

    for i=1:num_players
        for j=i+1:num_players
            match_result = run_axelrod_match(players[i], players[j], game_matrix, num_rounds)
        end
    end
end
