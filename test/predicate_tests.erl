-module(predicate_tests).
-include_lib("eunit/include/eunit.hrl").

empty_predicate_list_test() ->
    PredicateList = [],
    PredArg = whatever,
    ?assertEqual({ok, all_passed}, predicate:check(PredicateList, PredArg)).

one_true_predicate_test() ->
    F = fun true_or_false/1,
    PredicateList = [F],
    PredArg = true,
    ?assertEqual({ok, all_passed}, predicate:check(PredicateList, PredArg)).

many_true_predicate_test() ->
    F = fun true_or_false/1,
    PredicateList = [F, F, F, F, F],
    PredArg = true,
    ?assertEqual({ok, all_passed}, predicate:check(PredicateList, PredArg)).

one_false_predicate_test() ->
    F = fun true_or_false/1,
    PredicateList = [F],
    PredArg = false,
    ?assertMatch({error, _}, predicate:check(PredicateList, PredArg)).

one_false_predicate_in_the_middle_test() ->
    FalseF = fun(_) -> false end,
    F = fun true_or_false/1,
    PredicateList = [F, F, F, FalseF, F, F],
    PredArg = true,
    ?assertMatch({error, _}, predicate:check(PredicateList, PredArg)).

one_false_predicate_in_the_end_test() ->
    FalseF = fun(_) -> false end,
    F = fun true_or_false/1,
    PredicateList = [F, F, F, FalseF],
    PredArg = true,
    ?assertMatch({error, _}, predicate:check(PredicateList, PredArg)).

true_or_false(true) ->
    true;
true_or_false(false) ->
    false.
