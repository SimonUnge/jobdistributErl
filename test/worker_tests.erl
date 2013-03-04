-module(worker_tests).
-include_lib("eunit/include/eunit.hrl").

perform_echo_hello_job_test() ->   
    Id = 1,
    Command = "echo worker_hello_job",
    Job = job:create(Id, Command),
    ?assertMatch(ok, worker:execute_job(Job)).

perform_echo_good_bye_job_test() ->
    Job = "echo worker_goodbye_job",
    JobId = 1,
    ?assertMatch(ok, worker:execute_job(Job, JobId)).

perform_non_successfull_job_test() ->
    Job = "not_valid_job",
    JobId = 1,
    ?assertMatch(ok, worker:execute_job(Job, JobId)).
