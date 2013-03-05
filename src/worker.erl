-module(worker).
-export([
         execute_job/2,
         execute_job/1
        ]).

execute_job(Job) ->
    JobPort = open_port({spawn, job:get_command(Job)}, [exit_status]),
    Result = get_job_result(JobPort),
    return_result(Result, Job),
    ok.

execute_job(Job, Id) ->
    JobPort = open_port({spawn, Job}, [exit_status]),
    Result = get_job_result(JobPort),
    return_result(Result, Id),
    ok.

get_job_result(JobPort) ->
    receive
        {JobPort, {exit_status, Status}} ->
            Status
    end.

return_result(Result, Job) ->
    jd_manager:job_result(job:set_status(Result, Job)).
