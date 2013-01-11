-module(predicate).
-export([check/2]).

check([], true) ->
    {ok, all_passed};
check(_, false) ->
    {error, not_all_passed};
check([H | T], PredArg) ->
    check(T, H(PredArg)).
