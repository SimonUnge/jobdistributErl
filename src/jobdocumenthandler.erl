-module(jobdocumenthandler).
-include("include/jobdist.hrl").
-export([extract_job/1
         ,extract_do/1
         ,extract_executioner/1
         ,set_executioner/2
        ]).

extract_job(JobDoc) ->
    jobdoc:get_job(JobDoc).

extract_do(JobDoc) ->
    jobdoc:get_job_do(JobDoc).

extract_executioner(JobDoc) ->
    jobdoc:get_job_executioner(JobDoc).

set_executioner(JobDoc, Executioner) ->
    jobdoc:set_job_executioner(Executioner, JobDoc).


    
