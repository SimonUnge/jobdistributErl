-module(jobdoc).
-export([empty/0
         ,get_id/1
         ,get_job/1
         ,get_job_do/1
         ,get_job_executioner/1
	 ,get_job_winner/1
	 ,get_job_claimed_by/1
         ,set_id/2
         ,set_job_executioner/2
         ,set_job_do/2
	 ,set_job_winner/2
	 ,set_job_claimed_by/2
        ]).

-define(KEYINDEX,1).

empty() ->
    {[{<<"_id">>,<<>>},
      {<<"_rev">>,<<>>},
      {<<"job">>,
       {[
	 {<<"creator">>,<<>>},
	 {<<"winner">>,<<>>},
	 {<<"claimed_by">>,<<>>},
	 {<<"do">>,<<>>},
         {<<"executioner">>,<<>>}
        ]}
      }
     ]}.

%%% GETTERS
get_id(JD) ->
    get_value(<<"_id">>, JD).

get_job(JD) ->
    get_value(<<"job">>, JD).

get_job_do(JD) ->
    get_job_field_value(<<"do">>, JD).

get_job_executioner(JD) ->
    get_job_field_value(<<"executioner">>, JD).

get_job_field_value(Value, JD) ->
    Job = get_job(JD),
    get_value(Value, Job).

get_value(Key, JD) ->
    {JDL} = JD,
    proplists:get_value(Key, JDL).

get_job_winner(JD) ->
    get_job_field_value(<<"winner">>, JD).

get_job_claimed_by(JD) ->
    get_job_field_value(<<"claimed_by">>, JD).

%%% SETTERS
set_id(Value, JD) ->
    set_value(<<"_id">>, Value, JD).

set_job_executioner(Value, JD) ->
    set_job_field_value(<<"executioner">>, Value,JD).

set_job_do(Value, JD) ->
    set_job_field_value(<<"do">>, Value, JD).

set_job_winner(Value, JD) ->
    set_job_field_value(<<"winner">>, Value, JD).

set_job_claimed_by(Value, JD) ->
    set_job_field_value(<<"claimed_by">>, Value, JD).

set_job_field_value(Key, Value, JD) ->
    Job = get_job(JD),
    UpdatedJob = set_value(Key, Value, Job),
    set_value(<<"job">>, UpdatedJob, JD).

set_value(Key, Value, JD) ->
    {JDL} = JD,
    {lists:keyreplace(Key, ?KEYINDEX, JDL, {Key, Value})}.
