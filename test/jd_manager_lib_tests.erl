-module(jd_manager_lib_tests).
-include_lib("eunit/include/eunit.hrl").

invalidate_empty_job_test() ->
    Job = "",
    ?assertEqual(error, jd_manager_lib:validate_job(Job)).

validate_echo_hello_job_test() ->
    Job = "echo hello",
    JobId = whatever,
    ?assertEqual(ok, jd_manager_lib:validate_job(Job)).

give_job_to_spawned_worker_test() ->
    Job = "echo hello",
    JobId = whatever,
    ?assertEqual(ok, jd_manager_lib:give_job_to_worker(Job, JobId)).

someone_is_not_waiting_for_the_job_test() ->
    DbWithAwaiting = ets:new(whatever, []),
    JobId = 1,
    ?assertEqual(false, jd_manager_lib:is_someone_waiting_for_job(DbWithAwaiting, JobId)).

someone_is_waiting_for_the_job_test() ->
    DbWithAwaiting = ets:new(whatever, []),
    JobId = 1,
    ets:insert(DbWithAwaiting, {JobId, value}),
    ?assertEqual(true, jd_manager_lib:is_someone_waiting_for_job(DbWithAwaiting, JobId)).

job_is_not_executed_test() ->
    DbWithExecJobs = ets:new(whatever, []),
    JobId = 1,
    ?assertEqual(false, jd_manager_lib:is_job_executed(DbWithExecJobs, JobId)).

job_is_executed_test() ->
    DbWithExecJobs = ets:new(whatever, []),
    JobId = 1,
    ets:insert(DbWithExecJobs, {JobId, value}),
    ?assertEqual(true, jd_manager_lib:is_job_executed(DbWithExecJobs, JobId)).
