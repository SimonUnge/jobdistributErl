-module(jd_decode_tests).
-include_lib("eunit/include/eunit.hrl").
-include("include/jobdist.hrl").

decode_empty_jd_test() ->
    DecodeJd = {},
    Result = not_valid_jd,
    ?assertEqual(Result, jd_decode:decode(DecodeJd)).

decode_jd_with_one_valid_field_test() ->
    DecodeJd = {[{<<"_id">>,<<"some id">>}]},
    Result = #job_document{id = "some id"},
    ?assertEqual(Result, jd_decode:decode(DecodeJd)).

