input_time = [52947594]
input_dist = [426137412791216]

res = 1
for (i, time) in enumerate(input_time)
    count = 0
    for hold in range(1,time)
        remaining_time = time-hold
        if hold*remaining_time >= input_dist[i]
            count += 1
        end
    end
    global res *= count
end
println(res)