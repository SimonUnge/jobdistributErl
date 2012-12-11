-module(worker_tests).
-include_lib("eunit/include/eunit.hrl").
-include("include/jobdist.hrl").

perform_job_test() ->
    Job = #job{do = "echo hello"},
    ?assertMatch({ok, "hello\n"}, worker:execute_job(Job)).
