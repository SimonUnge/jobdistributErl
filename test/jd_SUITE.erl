-module(jd_SUITE).
-include_lib("common_test/include/ct.hrl").
-export([all/0, groups/0, init_per_group/2, end_per_group/2]).
-export([send_job_recv_result/1]).

all() ->
    [{group, jd}].

groups() ->
    [{jd, [], [send_job_recv_result]}].

init_per_group(jd, Config) ->
    ok = application:start(jobdistributerl),
    Config;
init_per_group(_, Config) ->
    Config.

end_per_group(jd, Config) ->
    ok = application:stop(jobdistributerl);
end_per_group(_, _Config) ->
    ok.

send_job_recv_result(_Config) ->
    Job = whatever,
    Result = jd_manager:give_job(Job),
    Result =/= undefined.
