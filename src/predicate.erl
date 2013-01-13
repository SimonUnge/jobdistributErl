
-module(predicate).
-export([check/2]).

check([], _) ->
    passed;
check([H | T], PredArg) ->
    case H(PredArg) of
        true ->
            check(T, PredArg);
        false ->
            error
    end.
