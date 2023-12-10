# AoC Day10 Part2
struct dsu
    p::Vector{Int}
    sz::Vector{Int}
end

function dsu(n)
    return dsu(collect(1:n), zeros(Int, n))
end

function get(d::dsu, x)
    if d.p[x] != x
        d.p[x] = get(d, d.p[x])
    end
    return d.p[x]
end

function unite(d::dsu, x, y)
    x = get(d, x)
    y = get(d, y)
    if x != y
        d.p[x] = y
        d.sz[y] += d.sz[x]
    end
end

function size(d::dsu, x)
    return d.sz[get(d, x)]
end

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

t = dsu((h + 1) * (w + 1))

for i in 1:h
    for j in 1:w
        if d[i, j] == -1
            unite(t, (i - 1) * (w + 1) + j, (i - 1) * (w + 1) + j + 1)
            unite(t, (i - 1) * (w + 1) + j, i * (w + 1) + j)
            unite(t, (i - 1) * (w + 1) + j, i * (w + 1) + j + 1)
        elseif s[i][j] != 'S'
            if !up(i, j)
                unite(t, (i - 1) * (w + 1) + j, (i - 1) * (w + 1) + j + 1)
            end
            if !down(i, j)
                unite(t, i * (w + 1) + j, i * (w + 1) + j + 1)
            end
            if !left(i, j)
                unite(t, (i - 1) * (w + 1) + j, i * (w + 1) + j)
            end
            if !right(i, j)
                unite(t, (i - 1) * (w + 1) + j + 1, i * (w + 1) + j + 1)
            end
        end
    end
end

ans = 0

for i in 1:h
    for j in 1:w
        if d[i, j] == -1 && get(t, 1) != get(t, (i - 1) * (w + 1) + j)
            # println(i, " ", j, " ", get(t, (i - 1) * (w + 1) + j))
            global ans += 1
        end
    end
end

println(ans)
