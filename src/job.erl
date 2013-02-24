-module(job).

-include("include/job.hrl").
-export([create/2,
	 get_id/1,
	 get_command/1,
	 get_status/1,
	 set_status/2
	]).

create(Id, Command) ->
    #job{id = Id, command = Command}.

get_id(Job) ->
    Job#job.id.

get_command(Job) ->
    Job#job.command.

get_status(Job) ->
    Job#job.status.

set_status(Status, Job) ->
    Job#job{status = Status}.
