-module(jd_manager_lib_tests).
-include_lib("eunit/include/eunit.hrl").

receive_empty_job_test() ->
    Job = "",
    ?assertEqual(error, jd_manager_lib:handle_job(Job)).

receive_echo_hello_job_test() ->
    Job = "echo hello",
    StatusCode = 0,
    ?assertMatch({ok, StatusCode, _}, jd_manager_lib:handle_job(Job)).

