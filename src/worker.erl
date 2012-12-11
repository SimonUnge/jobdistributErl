-module(worker).
-export([
         execute_job/1
        ]).

execute_job(Job) ->
    Result = os:cmd("echo hello"),
    {ok, Result}.
