-module(jobdocumenthandler_tests).
-include_lib("eunit/include/eunit.hrl").
-include("include/jobdist.hrl").

extract_job_test() ->
    Job = #job{},
    JobDoc = #job_document{job = Job},
    ?assertEqual(Job, jobdocumenthandler:extract_job(JobDoc)).

extract_job_do_test() ->
    Job = #job{do = foo},
    JobDoc = #job_document{job = Job},
    ?assertEqual(foo, jobdocumenthandler:extract_do(JobDoc)).

extract_job_executioner_test() ->
    Job = #job{executioner = worker_pid},
    JobDoc = #job_document{job = Job},
    ?assertEqual(worker_pid, jobdocumenthandler:extract_executioner(JobDoc)).

set_job_executioner_test() ->
    Job = #job{},
    JobDocNoExecutioner = #job_document{job = Job},
    NewJobDoc = jobdocumenthandler:set_executioner(JobDocNoExecutioner, pid),
    ?assertEqual(jobdocumenthandler:extract_executioner(NewJobDoc), pid).
