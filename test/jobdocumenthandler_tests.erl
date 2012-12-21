-module(jobdocumenthandler_tests).
-include_lib("eunit/include/eunit.hrl").
-include("include/jobdist.hrl").

extract_job_test() ->
    JobDoc = jobdoc:empty(),
    Job = jobdoc:get_job(JobDoc),
    ?assertEqual(Job, jobdocumenthandler:extract_job(JobDoc)).

extract_job_do_test() ->
    JobDoc = jobdoc:set_job_do(<<"echo hello">>, jobdoc:empty()),
    ?assertEqual(<<"echo hello">>, jobdocumenthandler:extract_do(JobDoc)).

extract_job_executioner_test() ->
    JobDoc = jobdoc:set_job_executioner(<<"worker_pid">>, jobdoc:empty()),
    ?assertEqual(<<"worker_pid">>, jobdocumenthandler:extract_executioner(JobDoc)).

set_job_executioner_test() ->
    JobDoc = jobdoc:empty(),
    NewJobDoc = jobdocumenthandler:set_executioner(JobDoc, <<"worker_pid">>),
    ?assertEqual(jobdocumenthandler:extract_executioner(NewJobDoc), <<"worker_pid">>).
