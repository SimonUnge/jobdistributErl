-module(jd_store).
-export([
         create_executed_jobs_db/0,
         create_awaiting_job_status_db/0,
         insert/3,
         lookup/2,
         delete/2
        ]).

create_executed_jobs_db() ->
    create(executed_jobs).
create_awaiting_job_status_db() ->
    create(awaiting_job_status).

create(Name) ->
    ets:new(Name, [named_table]).

insert(Db, Key, Value) ->
    ets:insert(Db, {Key ,Value}).

lookup(Db, Key) ->
    [{Key, Value}] = ets:lookup(Db, Key),
    Value.

delete(Db, key) ->
    ets:delete(Db, key).
    
