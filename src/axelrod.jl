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
"""
function markov_game_matrix(; tt=0.0, tf=0.0, ft=0.0, ff=0.0)
    M = [tt tf;
         ft ff]

    return M
end
