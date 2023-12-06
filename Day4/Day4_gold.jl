

fname = "input.txt"

f = open(fname, "r")
lines = readlines(f);
close(f)
res = 0
copies = ones(length(lines))
all_wins = zeros(size(copies))
for (i,line) in enumerate(lines)
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
    all_wins[i] = num_wins
    start_i = i+1
    if (i+1)+num_wins > length(copies)
        end_i = length(copies)
    else
        end_i = i+num_wins
    end
    copies[start_i:end_i] .+= 1*copies[i]
end
res += sum(copies)
println(res)