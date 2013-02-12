-module(jd_manager_lib_tests).
-include_lib("eunit/include/eunit.hrl").

invalidate_empty_job_test() ->
    Job = "",
    JobId = whatever,
    ?assertEqual(error, jd_manager_lib:validate_job({Job, JobId})).

validate_echo_hello_job_test() ->
    Job = "echo hello",
    JobId = whatever,
    ?assertEqual(ok, jd_manager_lib:validate_job({Job, JobId})).

