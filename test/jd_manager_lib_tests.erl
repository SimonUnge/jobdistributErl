-module(jd_manager_lib_tests).
-include_lib("eunit/include/eunit.hrl").

invalidate_empty_job_test() ->
    Job = "",
    ?assertEqual(error, jd_manager_lib:validate_job(Job)).

validate_echo_hello_job_test() ->
    Job = "echo hello",
    ?assertEqual(ok, jd_manager_lib:validate_job(Job)).

