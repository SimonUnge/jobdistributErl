-module(worker).
-include("include/jobdist.hrl").
-export([
         execute_job/1
        ]).
-record(result,{status, output = ""}).

execute_job(JobDo) ->
    JobPort = open_port({spawn, JobDo}, [exit_status]),
    Result = get_job_result(JobPort, #result{}),
    return_result(Result).

get_job_result(JobPort, Result) ->
    receive
        {JobPort, {exit_status, Status}} ->
            Result#result{status = Status};
        {JobPort, {data, Output}} ->
            OldOutput = Result#result.output,
            get_job_result(JobPort, Result#result{output = OldOutput ++ Output})
    end.

return_result(Result) ->
    case Result#result.status of
        0 ->
            {ok, Result#result.status, Result#result.output};
        Status when is_integer(Status) -> 
            {error, Status, Result#result.output}
    end.
