-module(jd_store_tests).
-include_lib("eunit/include/eunit.hrl").

create_executed_jobs_db_test() ->
    ?assertEqual(executed_jobs, jd_store:create_executed_jobs_db()).

create_awaiting_job_status_db() ->
    ?assertEqual(awaiting_job_status, jd_store:create_awaiting_job_status_db()).

lookup_stored_value_in_db_test() ->
    Db = jd_store:create(foo),
    Id = 1,
    Command = "whatever",
    Job = job:create(Id, Command),
    jd_store:insert(Db, Job),
    ?assertEqual(Job, jd_store:lookup(Db, Id)).

lookup_non_existing_value_in_db_test() ->
    Db = jd_store:create(bar),
    Id = 1,
    Command = "whatever",
    WrongKey = 2,
    Job = job:create(Id, Command),
    jd_store:insert(Db, Job),
    ?assertEqual([], jd_store:lookup(Db, WrongKey)).

delete_stored_value_in_db_test() ->
    Db = jd_store:create(ball),
    Id = 1,
    Command = "whatever",
    Job = job:create(Id, Command),
    jd_store:insert(Db, Job),
    jd_store:delete(Db, Id),
    ?assertEqual([], jd_store:lookup(Db, Id)).
