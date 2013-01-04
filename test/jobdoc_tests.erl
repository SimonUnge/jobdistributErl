-module(jobdoc_tests).
-include_lib("eunit/include/eunit.hrl").

return_empty_job_doc_template_test() ->
    ?assertEqual(jobdoc_template(), jobdoc:empty()).

get_id_test() ->
    JD = jobdoc_template(),
    ?assertEqual(<<>>, jobdoc:get_id(JD)).

get_job_test() ->
    JD = jobdoc_template(),
    Job = job_template(),
    ?assertEqual(Job, jobdoc:get_job(JD)).

get_job_do_test() ->
    JD = jobdoc_template(),
    ?assertEqual(<<>>, jobdoc:get_job_do(JD)).

get_job_executioner_test() ->
    JD = jobdoc_template(),
    ?assertEqual(<<>>, jobdoc:get_job_executioner(JD)).

get_job_winner_test() ->
    JD = jobdoc_template(),
    ?assertEqual(<<>>, jobdoc:get_job_winner(JD)).

get_job_claimed_by_test() ->
    JD = jobdoc_template(),
    ?assertEqual(<<>>, jobdoc:get_job_claimed_by(JD)).    

set_job_executioner_test() ->
    JD = jobdoc_template(),
    NewExecutionerJD = jobdoc:set_job_executioner(<<"new executioner">>,
                                                  JD),
    ?assertEqual(<<"new executioner">>, 
                 jobdoc:get_job_executioner(NewExecutionerJD)).

set_job_do_test() ->
    JD = jobdoc_template(),
    NewDoJD = jobdoc:set_job_do(<<"new job">>,
                                JD),
    ?assertEqual(<<"new job">>, 
                 jobdoc:get_job_do(NewDoJD)).

set_id_test() ->
    JD = jobdoc_template(),
    NewIDJD = jobdoc:set_id(<<"new id">>, JD),
    ?assertEqual(<<"new id">>, jobdoc:get_id(NewIDJD)).

set_job_winner_test() ->
    JD = jobdoc_template(),
    NewWinnerJD = jobdoc:set_job_winner(<<"new winner">>, JD),
    ?assertEqual(<<"new winner">>, jobdoc:get_job_winner(NewWinnerJD)).

set_job_claimed_by_test() ->
    JD = jobdoc_template(),
    NewClaimJD = jobdoc:set_job_claimed_by(<<"new claimer">>, JD),
    ?assertEqual(<<"new claimer">>, jobdoc:get_job_claimed_by(NewClaimJD)).

jobdoc_template() ->
    {[{<<"_id">>,<<>>},
      {<<"_rev">>,<<>>},
      {<<"job">>,
       job_template()
      }
     ]}.

job_template() ->
    {[
      {<<"creator">>,<<>>},
      {<<"winner">>,<<>>},
      {<<"claimed_by">>, <<>>},
      {<<"do">>,<<>>},
      {<<"executioner">>,<<>>}
     ]}.
