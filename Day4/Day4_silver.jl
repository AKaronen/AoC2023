

fname = "input.txt"

open(fname, "r") do f
    res = 0
    for line in eachline(f)
        game = split(line, ':')[2]
        left = split(game, '|')[1]
        right = split(game, '|')[2]
        winners = map(num -> parse(Int,num), split(left))
        lotto = map(num -> parse(Int,num), split(right))
        num_wins = 0
        for num in lotto
            matches = winners .== num
            if any(matches)
                num_wins += 1
            end
        end 

        pow = 0
        if num_wins > 0
            pow = num_wins - 1
            res +=  2^pow
            println("num_wins: ", num_wins, " pow: ", pow, " res: ", res)
        end 
    end
    println(res)
end