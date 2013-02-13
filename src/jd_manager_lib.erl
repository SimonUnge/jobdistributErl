-module(jd_manager_lib).
-export([
         validate_job/1,
         give_job_to_worker/2,
         is_someone_waiting_for_job/2,
         is_job_executed/2
        ]).

validate_job([]) ->
    error;
validate_job(Job) when is_list(Job)->
    ok.

give_job_to_worker(Job, JobId) ->
    spawn(worker, execute_job, [Job, JobId]),
    ok.

is_someone_waiting_for_job(AwaitingJobStatusDb, JobId) ->
    case jd_store:lookup(AwaitingJobStatusDb, JobId) of
        [] ->
            false;
        _ ->
            true
    end.
        

is_job_executed(ExecutedJobsDb, JobId) ->
    case jd_store:lookup(ExecutedJobsDb, JobId) of
        [] ->
            false;
        _ ->
            true
    end.
