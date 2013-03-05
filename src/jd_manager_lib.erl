-module(jd_manager_lib).
-export([
	 handle_job/1,
         is_someone_waiting_for_job/2,
         is_job_executed/2
        ]).

handle_job(Job) ->
    give_job_to_worker(Job),
    ok.

give_job_to_worker(Job) ->
    spawn(worker, execute_job, [Job]).

is_someone_waiting_for_job(AwaitingJobStatusDb, Job) ->
    case jd_store:lookup(AwaitingJobStatusDb, Job) of
        [] ->
            false;
        _ ->
            true
    end.
        

is_job_executed(ExecutedJobsDb, Job) ->
    case jd_store:lookup(ExecutedJobsDb, Job) of
        [] ->
            false;
        _ ->
            true
    end.
