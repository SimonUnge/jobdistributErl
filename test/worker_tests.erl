-module(worker_tests).
-include_lib("eunit/include/eunit.hrl").

perform_echo_hello_job_test() ->
    JobDo = "echo worker_hello_job",
    StatusCode = 0,
    ?assertMatch({ok, StatusCode, "worker_hello_job\n"}, worker:execute_job(JobDo)).

perform_echo_good_bye_job_test() ->
    JobDo = "echo worker_goodbye_job",
    StatusCode = 0,
    ?assertMatch({ok, StatusCode,"worker_goodbye_job\n"}, worker:execute_job(JobDo)).

perform_non_successfull_job_test() ->
    JobDo = "not_valid_do",
    ErrorCode = 127,
    PossibleReason = "",
    ?assertMatch({error, ErrorCode, PossibleReason}, worker:execute_job(JobDo)).

