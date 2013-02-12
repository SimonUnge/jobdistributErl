-module(jd_manager_lib).
-export([validate_job/1]).

validate_job({[], _}) ->
    error;
validate_job({Job, _}) when is_list(Job)->
    ok.
