-module(jd_SUITE).
-include_lib("common_test/include/ct.hrl").
-export([all/0, groups/0, init_per_group/2, end_per_group/2]).
-export([
         send_empty_job_recv_error/1,
         send_echo_job_recv_ok/1,
         send_job_and_ask_for_result/1
        ]).

all() ->
    [{group, jd}].

groups() ->
    [
     {jd, [], [
               send_empty_job_recv_error,
               send_echo_job_recv_ok,
               send_job_and_ask_for_result
              ]
     }
    ].


send_empty_job_recv_error(_Config) ->
    Job = "",
    JobId = 1,
    error = jd_manager:give_job({Job, 1}).

send_echo_job_recv_ok(_Config) ->
    Job = "echo hello",
    JobId = 1,
    ok = jd_manager:give_job({Job,1}).
        
send_job_and_ask_for_result(_Config) ->
    Job = "echo hello",
    JobId = 1,
    SuccessStaus = 0,
    ok = jd_manager:give_job({Job,1}),
    SuccessStaus = jd_manager:get_result().

init_per_group(jd, Config) ->
    ok = application:start(jobdistributerl),
    Config;
init_per_group(_, Config) ->
    Config.

end_per_group(jd, Config) ->
    ok = application:stop(jobdistributerl);
end_per_group(_, _Config) ->
    ok.
