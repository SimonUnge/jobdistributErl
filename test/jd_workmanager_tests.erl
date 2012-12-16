-module(jd_workmanager_tests).
-include_lib("eunit/include/eunit.hrl").
-include("include/jobdist.hrl").

get_job_doc_and_return_job_doc_test() ->
    application:start(jobdistributErl),
    Job = #job{do = "echo hello"},
    JobDoc = #job_document{job = Job},
    Result = jd_workmanager:get_job(JobDoc),
    ?assertEqual(true, is_record(Result, job_document)).

extract_job_test() ->
    application:start(jobdistributErl),
    Job = #job{do = "echo hello"},
    JobDoc = #job_document{job = Job},
    ?assertEqual(Job, jd_workmanager:extract_job(JobDoc)).

give_job_to_worker_and_get_updated_executioner_test() ->
    application:start(jobdistributErl),
    Job = #job{do = "echo hello"},
    ResultJob = jd_workmanager:give_job_to_worker(Job),
    ?assert(ResultJob#job.executioner =/= undefined).

give_job_to_worker_and_get_executioner_pid_test() ->
    application:start(jobdistributErl),
    Job = #job{do = "echo hello"},
    ResultJob = jd_workmanager:give_job_to_worker(Job),
    ?assertEqual(true, is_pid(ResultJob#job.executioner)).

get_job_doc_and_return_some_job_executioner_info_test() -> 
    application:start(jobdistributErl),
    Job = #job{do = "echo hello"},
    JobDoc = #job_document{job = Job},
    ResultDoc = jd_workmanager:get_job(JobDoc),
    ResultJob = ResultDoc#job_document.job,
    ?assert(ResultJob#job.executioner =/= undefined).

