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
    StatusCode = Result#result.status,
    Output = Result#result.output,
    Status = determin_if_status_is_ok(StatusCode),
    {Status, StatusCode, Output}.

determin_if_status_is_ok(StatusCode) ->
    case StatusCode of
        0 ->
            ok;
        _N ->
            error
    end.
