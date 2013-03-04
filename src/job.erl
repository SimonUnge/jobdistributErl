-module(job).

-include("inc/job.hrl").
-export([create/2,
	 create/1,
	 get_id/1,
	 get_command/1,
	 get_status/1,
	 set_status/2
	]).

-define(MAX_ID_NUMBER, 10000000).


create(Command) ->
    validate_created_job(#job{id = generate_random_id_number(),
			      command = Command}).

create(Id, Command) ->
    validate_created_job(#job{id = Id, command = Command}).

validate_created_job(Job) ->
    case validate_job(Job, validation_steps()) of
	true ->
	    Job;
	false ->
	    error
    end.

get_id(Job) ->
    Job#job.id.

get_command(Job) ->
    Job#job.command.

get_status(Job) ->
    Job#job.status.

set_status(Status, Job) ->
    Job#job{status = Status}.

validation_steps() ->
    [fun valid_id/1, fun valid_command/1].

valid_id(Job) ->
    is_integer(Job#job.id).

valid_command(Job) ->
    is_list(Job#job.command).

validate_job(Job, Predicates) ->
    validate(true, Job, Predicates).

validate(true, Job, [H | T]) ->
    validate(H(Job), Job, T);
validate(true, _Job, []) ->
    true;
validate(false, _, _) ->
    false.

generate_random_id_number() ->
    {MegaSecs, Secs, MicroSecs} = now(),
    random:seed(MegaSecs, Secs, MicroSecs),
    random:uniform(?MAX_ID_NUMBER).
