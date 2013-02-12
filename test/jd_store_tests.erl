-module(jd_store_tests).
-include_lib("eunit/include/eunit.hrl").

create_executed_jobs_db_test() ->
    ?assertEqual(executed_jobs, jd_store:create_executed_jobs_db()).

create_awaiting_job_status_db() ->
    ?assertEqual(awaiting_job_status, jd_store:create_awaiting_job_status_db()).

insert_into_db_test() ->
    Db = ets:new(temp, []),
    Key = key,
    Value = value,
    ?assertEqual(true, jd_store:insert(Db, Key, Value)).

lookup_stored_value_in_db_test() ->
    Db = ets:new(temp, []),
    ets:insert(Db, {key, value}),
    ?assertEqual(value, jd_store:lookup(Db, key)).

delete_stored_value_in_db_test() ->
    Db = ets:new(temp, []),
    ets:insert(Db, {key, value}),
    jd_store:delete(Db, key),
    ?assertEqual([], ets:lookup(Db, key)).
