-module(jobdocumenthandler).
-export([extract_job/1
         ,extract_do/1
         ,extract_executioner/1
	 ,extract_winner/1
	 ,extract_claimed_by/1
         ,set_executioner/2
	 ,set_claimed_by/2
        ]).

extract_job(JobDoc) ->
    jobdoc:get_job(JobDoc).

extract_do(JobDoc) ->
    binary_to_list(jobdoc:get_job_do(JobDoc)).

extract_executioner(JobDoc) ->
    binary_to_list(jobdoc:get_job_executioner(JobDoc)).

extract_winner(JobDoc) ->
    binary_to_list(jobdoc:get_job_winner(JobDoc)).

extract_claimed_by(JobDoc) ->
    binary_to_list(jobdoc:get_job_claimed_by(JobDoc)).

set_executioner(Executioner, JobDoc) ->
    BinaryPid = list_to_binary(pid_to_list(Executioner)),
    jobdoc:set_job_executioner(BinaryPid, JobDoc).

set_claimed_by(Claimer, JobDoc) ->
    BinaryClaimer = list_to_binary(Claimer),
    jobdoc:set_job_claimed_by(BinaryClaimer, JobDoc).
    
