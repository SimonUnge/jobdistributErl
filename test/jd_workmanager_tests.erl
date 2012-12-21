-module(jd_workmanager_tests).
-include_lib("eunit/include/eunit.hrl").
-include("include/jobdist.hrl").

get_job_doc_and_return_job_doc_test() ->
    application:start(jobdistributErl),    
    JobDoc = jobdoc:empty(),
    ?assertMatch({[{<<"_id">>, null} | _]}, jd_workmanager:give_job(JobDoc)).

give_job_to_worker_and_get_updated_executioner_test() ->
    application:start(jobdistributErl),
    JobDoc = jobdoc:set_job_do(<<"echo hello">>, jobdoc:empty()),
    ResultJobDoc = jd_workmanager:create_executing_worker(JobDoc),
    ?assert(jobdocumenthandler:extract_executioner(ResultJobDoc) =/= null).

give_job_to_worker_and_get_executioner_pid_test() ->
    application:start(jobdistributErl),
    JobDoc = jobdoc:set_job_do(<<"echo hello">>, jobdoc:empty()),
    ResultJobDoc = jd_workmanager:create_executing_worker(JobDoc),
    ?assertEqual(true, is_pid(jobdocumenthandler:extract_executioner(ResultJobDoc))).

get_job_doc_and_return_some_job_executioner_info_test() -> 
    application:start(jobdistributErl),
    JobDoc = jobdoc:set_job_do(<<"echo hello">>, jobdoc:empty()),
    ResultDoc = jd_workmanager:give_job(JobDoc),
    ?assert(jobdoc:get_job_executioner(ResultDoc) =/= null).

