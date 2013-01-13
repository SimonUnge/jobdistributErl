-module(predicate_tests).
-include_lib("eunit/include/eunit.hrl").

empty_predicate_list_test() ->
    PredicateList = [],
    PredArg = true,
    ?assertEqual(passed, predicate:check(PredicateList, PredArg)).

one_true_predicate_test() ->
    F = fun true_or_false/1,
    PredicateList = [F],
    PredArg = true,
    ?assertEqual(passed, predicate:check(PredicateList, PredArg)).

many_true_predicate_test() ->
    F = fun true_or_false/1,
    PredicateList = [F, F, F, F, F],
    PredArg = true,
    ?assertEqual(passed, predicate:check(PredicateList, PredArg)).

one_false_predicate_test() ->
    F = fun true_or_false/1,
    PredicateList = [F],
    PredArg = false,
    ?assertEqual(error, predicate:check(PredicateList, PredArg)).

one_false_predicate_in_the_middle_test() ->
    FalseF = fun(_) -> false end,
    F = fun true_or_false/1,
    PredicateList = [F, F, F, FalseF, F, F],
    PredArg = true,
    ?assertEqual(error, predicate:check(PredicateList, PredArg)).

one_false_predicate_in_the_end_test() ->
    FalseF = fun(_) -> false end,
    F = fun true_or_false/1,
    PredicateList = [F, F, F, FalseF],
    PredArg = true,
    ?assertEqual(error, predicate:check(PredicateList, PredArg)).

word_characteristic_predicate_test() ->
    PredicateFuns = [fun is_non_empty/1, fun is_word/1, fun is_palindrome/1],
    PredArg = "abba",
    ?assertEqual(passed, predicate:check(PredicateFuns, PredArg)).



is_non_empty(Word) ->
    length(Word) > 0.
is_word(Word) ->
    is_list(Word).
is_palindrome(Word) ->
    Word =:= lists:reverse(Word).

true_or_false(true) ->
    true;
true_or_false(false) ->
    false.
