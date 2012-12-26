-module(jobdoc_tests).
-include_lib("eunit/include/eunit.hrl").
-include("include/jobdist.hrl").

return_empty_job_doc_template_test() ->
    ?assertEqual(job_template(), jobdoc:empty()).

get_id_test() ->
    JD = job_template(),
    ?assertEqual(<<>>, jobdoc:get_id(JD)).

get_job_test() ->
    JD = job_template(),
    Job = {[{<<"do">>,<<>>},
         {<<"executioner">>,<<>>}
        ]},
    ?assertEqual(Job, jobdoc:get_job(JD)).

get_job_do_test() ->
    JD = job_template(),
    ?assertEqual(<<>>, jobdoc:get_job_do(JD)).

get_job_executioner_test() ->
    JD = job_template(),
    ?assertEqual(<<>>, jobdoc:get_job_executioner(JD)).

set_job_executioner_test() ->
    JD = job_template(),
    NewExecutionerJD = jobdoc:set_job_executioner(<<"new executioner">>,
                                                  JD),
    ?assertEqual(<<"new executioner">>, 
                 jobdoc:get_job_executioner(NewExecutionerJD)).

set_job_do_test() ->
    JD = job_template(),
    NewDoJD = jobdoc:set_job_do(<<"new job">>,
                                JD),
    ?assertEqual(<<"new job">>, 
                 jobdoc:get_job_do(NewDoJD)).

set_id_test() ->
    JD = job_template(),
    NewIDJD = jobdoc:set_id(<<"new id">>, JD),
    ?assertEqual(<<"new id">>, jobdoc:get_id(NewIDJD)).

%%%
job_template() ->
    {[{<<"_id">>,<<>>},
      {<<"_rev">>,<<>>},
      {<<"job">>,
       {[{<<"do">>,<<>>},
         {<<"executioner">>,<<>>}
        ]}
      }
     ]}.

        
