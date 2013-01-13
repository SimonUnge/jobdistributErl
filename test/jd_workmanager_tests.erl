-module(jd_workmanager_tests).
-include_lib("eunit/include/eunit.hrl").
-define(NODENAME,"foo").
jd_test_() ->
    {foreach,
     fun setup/0,
     fun cleanup/1,
     [
      fun get_job_doc_and_return_job_doc/0,
      fun give_job_to_worker_and_get_updated_executioner/0,
      fun claim_unclaimed_job/0,
      {"Execute won job",fun execute_won_job/0},
      fun get_node_name/0,
      fun set_node_name/0
     ]}.

setup() ->
    application:start(jobdistributErl),
    jd_workmanager:set_node_name(?NODENAME).

cleanup(_) ->
    application:stop(jobdistributErl).

get_job_doc_and_return_job_doc() ->
    JobDoc = jobdoc:empty(),
    ?assertMatch({[{<<"_id">>, <<>>} | _]}, jd_workmanager:give_job(JobDoc)).

give_job_to_worker_and_get_updated_executioner() ->
    JobDoc = jobdoc:set_job_do(<<"echo jd_give_job_hello">>, jobdoc:empty()),
    ResultJobDoc = jd_workmanager:create_executing_worker(JobDoc),
    ?assert(jobdocumenthandler:extract_executioner(ResultJobDoc) =/= "").

claim_unclaimed_job() ->
    ResultJD = jd_workmanager:give_job(jobdoc:empty()),
    ?assertEqual(?NODENAME, jobdocumenthandler:extract_claimed_by(ResultJD)).

execute_won_job() ->
    ResultJD = jd_workmanager:give_job(won_job_doc()),
    ?assert(jobdocumenthandler:extract_executioner(ResultJD) =/= "").

get_node_name() ->
    ?assertEqual("foo", jd_workmanager:get_node_name()).

set_node_name() ->
    ok = jd_workmanager:set_node_name("bar"),
    ?assertEqual("bar", jd_workmanager:get_node_name()). 

%%% Internals
won_job_doc() ->
    EmptyJobDoc = jobdoc:empty(),
    WithDo = jobdoc:set_job_do(<<"echo won_job_doc">>, EmptyJobDoc),
    WithClaim = jobdoc:set_job_claimed_by(<<?NODENAME>>, WithDo),
    WonJobDoc = jobdoc:set_job_winner(<<?NODENAME>>, WithClaim).


