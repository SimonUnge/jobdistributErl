-module(jobdocumenthandler).
-include("include/jobdist.hrl").
-export([extract_job/1
         ,extract_do/1
         ,extract_executioner/1
         ,set_executioner/2
        ]).

extract_job(JobDoc) when is_record(JobDoc, job_document) ->
    JobDoc#job_document.job.

extract_do(JobDoc) ->
    Job = extract_job(JobDoc),
    Job#job.do.

extract_executioner(JobDoc) ->
    Job = extract_job(JobDoc),
    Job#job.executioner.

set_executioner(JobDoc, Executioner) ->
    Job = extract_job(JobDoc),
    JobDoc#job_document{job = Job#job{executioner = Executioner}}.
