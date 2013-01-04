-module(jobdocumenthandler_tests).
-include_lib("eunit/include/eunit.hrl").

extract_job_test() ->
    JobDoc = jobdoc:empty(),
    Job = jobdoc:get_job(JobDoc),
    ?assertEqual(Job, jobdocumenthandler:extract_job(JobDoc)).

extract_job_do_test() ->
    JobDoc = jobdoc:set_job_do(<<"echo hello">>, jobdoc:empty()),
    ?assertEqual("echo hello", jobdocumenthandler:extract_do(JobDoc)).

extract_job_executioner_test() ->
    JobDoc = jobdoc:set_job_executioner(<<"worker_pid">>, jobdoc:empty()),
    ?assertEqual("worker_pid", jobdocumenthandler:extract_executioner(JobDoc)).

extract_job_winner_test() ->
    JobDoc = jobdoc:set_job_winner(<<"the champ">>, jobdoc:empty()),
    ?assertEqual("the champ", jobdocumenthandler:extract_winner(JobDoc)).

extract_job_claimed_by_test() ->
    JobDoc = jobdoc:set_job_claimed_by(<<"the champ">>, jobdoc:empty()),
    ?assertEqual("the champ", jobdocumenthandler:extract_claimed_by(JobDoc)).

set_job_executioner_test() ->
    JobDoc = jobdoc:empty(),
    WorkerPid = spawn(lists, reverse, [[]]),
    NewJobDoc = jobdocumenthandler:set_executioner(WorkerPid, JobDoc),
    ?assertEqual(jobdocumenthandler:extract_executioner(NewJobDoc), pid_to_list(WorkerPid)).

set_job_claimed_by_test() ->
    JobDoc = jobdoc:empty(),
    NewJobDoc = jobdocumenthandler:set_claimed_by("the champ", JobDoc),
    ?assertEqual(jobdocumenthandler:extract_claimed_by(NewJobDoc), "the champ"). 
