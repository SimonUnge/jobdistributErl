-module(jd_store).
-export([
         create_executed_jobs_db/0,
         create_awaiting_job_status_db/0,
	 create/1,
         insert/2,
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

insert(Db, Job) ->
    ets:insert(Db, {job:get_id(Job), Job}).

insert(Db, Job, From) ->
    ets:insert(Db, {job:get_id(Job), From}).

lookup(Db, Job) ->
    Key = job:get_id(Job),
    case ets:lookup(Db, Key) of
        [{Key, Value}] ->
            Value;
        [] ->
            []
    end.

delete(Db, Job) ->
    ets:delete(Db, job:get_id(Job)).
    
