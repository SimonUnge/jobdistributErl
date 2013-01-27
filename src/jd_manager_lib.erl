-module(jd_manager_lib).
-export([handle_job/1]).

handle_job([]) ->
    error;
handle_job(Job) ->
    worker:execute_job(Job).
