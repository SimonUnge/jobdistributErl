-module(predicate).
-export([check/2]).

check([], PredArg) ->
    {ok, all_passed};
check(PredList, PredArg) ->
    %% case H(PredArg) of
    %%     true ->
    %%         check(T, PredArg);
    %%     false ->
    %%         {error, H}
    %% end.
    case all_true(PredList, PredArg) of
        true ->
            {ok, all_passed};
        false ->
            {error, not_all_passed}
    end.
all_true(PredList, PredArg) ->
    lists:foldl(fun(X, Acc) -> X(PredArg) =:= Acc end,true,PredList).

    

