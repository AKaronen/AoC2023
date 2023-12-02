using ReadableRegex
fname = "input.txt"

reg1 = @compile look_for(one_or_more(DIGIT), before = ":")
reg2 = @compile look_for(one_or_more([WORD]))

rgb = Dict([("red",1), ("green",2), ("blue", 3)])

open(fname,"r") do f
    result = 0
    for game in eachline(f)
        id = parse(Int, match(reg1, game).match)
        game = split(game, ":")[2]
        draws = split(game, ";")
        min_rgb = zeros(3)
        pow = 0
        for (j, draw) in enumerate(draws)
            words = collect.(eachmatch.(reg2, draw))
            nums = map(num-> parse(Int, num.match), words[1:2:length(words)])
            cols = map(col-> String(col.match), words[2:2:length(words)])
            for (i, num) in enumerate(nums)
                color_index = rgb[cols[i]]
                min_rgb[color_index] = max(num, min_rgb[color_index])
            end
        end
        pow = cumprod(min_rgb)[end]
        #println("Min: ", min_rgb, "\nPow: ", pow, "\nId: ", id)
        result += pow
    end
    println(result)
end
