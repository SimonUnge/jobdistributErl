-module(jd_manager_lib).
-export([
         validate_and_execute_job/2,
         give_job_to_worker/2,
         is_someone_waiting_for_job/2,
         is_job_executed/2
        ]).

validate_and_execute_job([], _) ->
    error;
validate_and_execute_job(Job, JobId) when is_list(Job)->
    give_job_to_worker(Job, JobId).

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
