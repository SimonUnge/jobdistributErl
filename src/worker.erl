-module(worker).
-export([
         execute_job/1
        ]).
-record(result,{status, output = ""}).

execute_job(Job) ->
    JobPort = open_port({spawn, Job}, [exit_status]),
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
    StatusCode = Result#result.status,
    Output = Result#result.output,
    Status = determine_if_status_is_ok(StatusCode),
    {Status, StatusCode, Output}.

determine_if_status_is_ok(0) ->
    ok;
determine_if_status_is_ok(_N) ->
    error.
