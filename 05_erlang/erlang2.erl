% AoC Day5 Part2
-module(erlang1).
-export([main/1]).

getline() ->
    S = io:get_line(""),
    T = string:trim(S),
    string:split(T, " ", all).

seg_append(C, []) ->
    C;
seg_append(C, [First, Second | Rest]) ->
    case Second of
        Second when Second > 0 ->
            seg_append(lists:append(C, [First, Second]), Rest);
        Second ->
            seg_append(C, Rest)
    end.

applyrule([], B, C, _) ->
    {B, C};
applyrule([First, Second | Rest], B, C, T) ->
    L = erlang:max(lists:nth(2, T), First),
    R = erlang:min(lists:nth(2, T) + lists:nth(3, T), First + Second),
    D = lists:nth(1, T) - lists:nth(2, T),
    case L of
        _ when L < R ->
            applyrule(Rest, lists:append(B, [L + D, R - L]), seg_append(C, [First, L - First, R, First + Second - R]), T);
        _ ->
            applyrule(Rest, B, lists:append(C, [First, Second]), T)
    end.

convert(A, B) ->
    case io:get_line("") of
        eof ->
            lists:append(A, B);
        S when S == "\n" ->
            lists:append(A, B);
        S ->
            %io:format("~w ~w~n", [length(A), length(B)]),
            U = string:split(string:trim(S), " ", all),
            T = lists:map(fun(X) -> list_to_integer(X) end, U),
            C = [],
            {P, Q} = applyrule(A, B, C, T),
            convert(Q, P)
    end.

mapping(A) ->
    %print_int_list(A),
    case io:get_line("") of
        eof ->
            A;
        _ ->
            B = [],
            mapping(convert(A, B))
    end.

oddmin([]) ->
    10000000000;
oddmin([First, _ | Rest]) ->
    erlang:min(First, oddmin(Rest)).

solve() ->
    S = lists:map(fun(X) -> list_to_integer(X) end, tl(getline())),
    io:get_line(""),
    Ans = mapping(S),
    io:format("~w~n", [oddmin(Ans)]),
    ok.

main(_) ->
    solve(),
    halt().

%print_int_list([]) ->
%    io:format("\n"),
%    ok;
%print_int_list([Head | Tail]) ->
%    io:format("~w ", [Head]),
%    print_int_list(Tail).
