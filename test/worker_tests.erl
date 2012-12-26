-module(worker_tests).
-include_lib("eunit/include/eunit.hrl").
-include("include/jobdist.hrl").

perform_echo_hello_job_test() ->
    JobDo = "echo hello",
    StatusCode = 0,
    ?assertMatch({ok, StatusCode, "hello\n"}, worker:execute_job(JobDo)).

perform_echo_good_bye_job_test() ->
    JobDo = "echo good bye",
    StatusCode = 0,
    ?assertMatch({ok, StatusCode,"good bye\n"}, worker:execute_job(JobDo)).

perform_non_successfull_job_test() ->
    JobDo = "not_valid_do",
    ErrorCode = 127,
    PossibleReason = "",
    ?assertMatch({error, ErrorCode, PossibleReason}, worker:execute_job(JobDo)).

