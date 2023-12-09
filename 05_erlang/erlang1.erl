% AoC Day5 Part1
-module(erlang1).
-export([main/1]).

getline() ->
    S = io:get_line(""),
    T = string:trim(S),
    string:split(T, " ", all).

applyrule(X, T) ->
    L = lists:nth(2, T),
    R = lists:nth(2, T) + lists:nth(3, T),
    case X of
        _ when X < L orelse R =< X ->
            X;
        _ ->
            -lists:nth(1, T) + lists:nth(2, T) - X
    end.

convert(A) ->
    case io:get_line("") of
        eof ->
            A;
        S when S == "\n" ->
            A;
        S ->
            U = string:split(string:trim(S), " ", all),
            T = lists:map(fun(X) -> list_to_integer(X) end, U),
            convert(lists:map(fun(X) -> applyrule(X, T) end, A))
    end.

mapping(A) ->
    case io:get_line("") of
        eof ->
            A;
        _ ->
            mapping(lists:map(fun(X) -> erlang:max(X, -X) end, convert(A)))
    end.

solve() ->
    S = lists:map(fun(X) -> list_to_integer(X) end, tl(getline())),
    io:get_line(""),
    Ans = mapping(S),
    io:format("~w~n", [lists:min(Ans)]),
    ok.

main(_) ->
    solve(),
    halt().
