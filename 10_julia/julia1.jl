# AoC Day10 Part1
s = []
while (true) 
    if eof(stdin)
        break
    end
    push!(s, chomp(readline(stdin)))
end

h = length(s)
w = length(s[1])
d = fill(-1, h, w)

up = (x, y) -> s[x][y] in "S|LJ"
down = (x, y) -> s[x][y] in "S|F7"
left = (x, y) -> s[x][y] in "S-7J"
right = (x, y) -> s[x][y] in "S-FL"

function bfs(sx, sy)
    que = [(sx, sy)]
    d[sx, sy] = 0
    while !isempty(que)
        (x, y) = popfirst!(que)
        # println(x, " ", y)
        if x - 1 >= 1 && up(x, y) && down(x - 1, y) && d[x - 1, y] == -1
            d[x - 1, y] = d[x, y] + 1
            push!(que, (x - 1, y))
        end
        if x + 1 <= h && down(x, y) && up(x + 1, y) && d[x + 1, y] == -1
            d[x + 1, y] = d[x, y] + 1
            push!(que, (x + 1, y))
        end
        if y - 1 >= 1 && left(x, y) && right(x, y - 1) && d[x, y - 1] == -1
            d[x, y - 1] = d[x, y] + 1
            push!(que, (x, y - 1))
        end
        if y + 1 <= w && right(x, y) && left(x, y + 1) && d[x, y + 1] == -1
            d[x, y + 1] = d[x, y] + 1
            push!(que, (x, y + 1))
        end
    end
end

for i in 1:h
    for j in 1:w
        if s[i][j] == 'S'
            bfs(i, j)
        end
    end
end

println(maximum(d))
