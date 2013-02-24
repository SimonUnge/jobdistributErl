-module(job_tests).

-include_lib("eunit/include/eunit.hrl").
-include("include/job.hrl").

create_job_test() ->
    Id = 1,
    Command = "whatever",
    ?assert(is_record(job:create(Id, Command), job)).

get_job_id_test() ->
    Id = 1,
    ?assertEqual(Id, job:get_id(job())).

get_job_command_test() ->
    Command = "whatever",
    ?assertEqual(Command, job:get_command(job())).

get_undefined_job_status_test() ->
    ?assertEqual(undefined, job:get_status(job())).

set_job_status_test() ->
    Status = 0,
    JobWithStatus = job:set_status(Status, job()),
    ?assertEqual(Status, job:get_status(JobWithStatus)).


job() ->
    Id = 1,
    Command = "whatever",
    job:create(Id, Command).
