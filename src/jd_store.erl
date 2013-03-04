-module(jd_store).
-export([
         create_executed_jobs_db/0,
         create_awaiting_job_status_db/0,
	 create/1,
         insert/2,
         lookup/2,
         delete/2
        ]).

create_executed_jobs_db() ->
    create(executed_jobs).
create_awaiting_job_status_db() ->
    create(awaiting_job_status).

create(Name) ->
    ets:new(Name, [named_table]).

insert(Db, Job) ->
    ets:insert(Db, {job:get_id(Job) ,Job}).

lookup(Db, Key) ->
    case ets:lookup(Db, Key) of
        [{Key, Value}] ->
            Value;
        [] ->
            []
    end.

delete(Db, Key) ->
    ets:delete(Db, Key).
    
