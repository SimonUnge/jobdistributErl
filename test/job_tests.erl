-module(job_tests).

-include("inc/job.hrl").
-include_lib("eunit/include/eunit.hrl").

create_job_with_invalid_commad_test() ->
    Command = not_a_string,
    ?assertEqual(error, job:create(Command)).

create_job_test() ->
    Command = "whatever",
    ?assert(is_record(job:create(Command), job)).

get_job_id_test() ->
    ?assert(is_integer(job:get_id(job()))).

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
    Command = "whatever",
    job:create(Command).
