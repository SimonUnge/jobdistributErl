-module(jd_store_tests).
-include_lib("eunit/include/eunit.hrl").

create_executed_jobs_db_test() ->
    ?assertEqual(executed_jobs, jd_store:create_executed_jobs_db()).

create_awaiting_job_status_db() ->
    ?assertEqual(awaiting_job_status, jd_store:create_awaiting_job_status_db()).

lookup_stored_value_in_db_test() ->
    Db = jd_store:create(foo),
    Command = "whatever",
    Job = job:create(Command),
    jd_store:insert(Db, Job),
    ?assertEqual(Job, jd_store:lookup(Db, Job)).

lookup_non_existing_value_in_db_test() ->
    Db = jd_store:create(bar),
    Command = "whatever",
    Job = job:create(Command),
    WrongJob = job:create(Command),
    jd_store:insert(Db, Job),
    ?assertEqual([], jd_store:lookup(Db, WrongJob)).

delete_stored_value_in_db_test() ->
    Db = jd_store:create(ball),
    Command = "whatever",
    Job = job:create(Command),
    jd_store:insert(Db, Job),
    jd_store:delete(Db, Job),
    ?assertEqual([], jd_store:lookup(Db, Job)).
