-module(jd_manager_lib).
-export([validate_job/1]).

validate_job([]) ->
    error;
validate_job(Job) when is_list(Job)->
    ok.
