
-module(predicate).
-export([check/2]).

check([], _) ->
    passed;
check([H | T], PredArg) ->
    combinator(H(PredArg), {fun check/2, T, PredArg}).

combinator(true, {F,A1,A2}) ->
    F(A1, A2);
combinator(false,_) ->
    error.





