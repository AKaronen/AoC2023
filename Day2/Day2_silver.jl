using ReadableRegex
fname = "input.txt"


bag = Dict([("red", 12), ("green", 13), ("blue", 14)])

reg1 = @compile look_for(one_or_more(DIGIT), before = ":")
reg2 = @compile look_for(one_or_more([WORD]))
        
open(fname,"r") do f
    result = 0
    for game in eachline(f)
        id = parse(Int, match(reg1, game).match)
        game = split(game, ":")[2]
        draws = split(game, ";")
        satisfies = falses(length(draws))
        for (j, draw) in enumerate(draws)
            words = collect.(eachmatch.(reg2, draw))
            nums = words[1:2:length(words)]
            cols = words[2:2:length(words)]
            temp = 0
            for (i, col) in enumerate(cols)
                bag_amount = bag[col.match]
                draw_amount = parse(Int,nums[i].match)
                if bag_amount >= draw_amount
                    temp += 1
                end
            end
            if temp == length(cols)
                satisfies[j] = true
            end
            if all(satisfies)
                result += id
            end
        end
    end
    println(result)
end
