-module(worker_tests).
-include_lib("eunit/include/eunit.hrl").

perform_echo_hello_job_test() ->   
    Command = "echo worker_hello_job",
    Job = job:create(Command),
    ?assertMatch(ok, worker:execute_job(Job)).

perform_echo_good_bye_job_test() ->
    Command = "echo worker_goodbye_job",
    Job = job:create(Command),
    ?assertMatch(ok, worker:execute_job(Job)).

perform_non_successfull_job_test() ->
    Command = "not_valid_job",
    Job = job:create(Command),
    ?assertMatch(ok, worker:execute_job(Job)).
