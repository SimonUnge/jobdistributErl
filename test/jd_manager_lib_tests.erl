-module(jd_manager_lib_tests).
-include_lib("eunit/include/eunit.hrl").

execute_echo_hello_job_test() ->
    Command = "echo hello",
    JobId = 1,
    ?assertEqual(ok, jd_manager_lib:handle_job(job:create(JobId, Command))).

someone_is_not_waiting_for_the_job_test() ->
    DbWithAwaiting = ets:new(whatever, []),
    Id = 1,
    Command = "whatever",
    Job = job:create(Id, Command),
    ?assertEqual(false, jd_manager_lib:is_someone_waiting_for_job(DbWithAwaiting, Job)).

someone_is_waiting_for_the_job_test() ->
    DbWithAwaiting = ets:new(whatever, []),
    Id = 1,
    Command = "whatever",
    Job = job:create(Id, Command),
    jd_store:insert(DbWithAwaiting, Job),
    ?assertEqual(true, jd_manager_lib:is_someone_waiting_for_job(DbWithAwaiting, Job)).

job_is_not_executed_test() ->
    DbWithExecJobs = ets:new(whatever, []),
    Id = 1,
    Command = "whatever",
    Job = job:create(Id, Command),
    ?assertEqual(false, jd_manager_lib:is_job_executed(DbWithExecJobs, Job)).

job_is_executed_test() ->
    DbWithExecJobs = ets:new(whatever, []),
    Id = 1,
    Command = "whatever",
    Job = job:create(Id, Command),
    jd_store:insert(DbWithExecJobs, Job),
    ?assertEqual(true, jd_manager_lib:is_job_executed(DbWithExecJobs, Job)).
