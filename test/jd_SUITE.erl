-module(jd_SUITE).
-include_lib("common_test/include/ct.hrl").
-export([all/0, groups/0, init_per_group/2, end_per_group/2]).
-export([
         send_empty_job_recv_error/1,
         send_echo_job_recv_ok/1,
         send_valid_job_and_ask_for_result/1,
         send_valid_long_job_and_ask_for_result/1,
         send_invalid_job_and_ask_for_result/1
        ]).

all() ->
    [{group, jd}].

groups() ->
    [
     {jd, [], [
               send_empty_job_recv_error,
               send_echo_job_recv_ok,
               send_valid_job_and_ask_for_result,
               send_valid_long_job_and_ask_for_result,
               send_invalid_job_and_ask_for_result
              ]
     }
    ].


send_empty_job_recv_error(_Config) ->
    Job = "",
    JobId = 1,
    error = jd_manager:give_job({Job, JobId}).

send_echo_job_recv_ok(_Config) ->
    Job = "echo hello",
    JobId = 2,
    ok = jd_manager:give_job({Job,JobId}).

send_valid_job_and_ask_for_result(_Config) ->
    Job = "echo hello",
    JobId = 3,
    SuccessStaus = 0,
    ok = jd_manager:give_job({Job,JobId}),
    SuccessStaus = jd_manager:get_job_result(JobId).

send_valid_long_job_and_ask_for_result(_Config) ->
    Job = "sleep 1",
    JobId = 4,
    SuccessStaus = 0,
    ok = jd_manager:give_job({Job, JobId}),
    SuccessStaus = jd_manager:get_job_result(JobId).

send_invalid_job_and_ask_for_result(_Config) ->
    Job = "invalid_job",
    JobId = 5,
    ok = jd_manager:give_job({Job, JobId}),
    0 =/= jd_manager:get_job_result(JobId).

init_per_group(jd, Config) ->
    ok = application:start(jobdistributerl),
    Config;
init_per_group(_, Config) ->
    Config.

end_per_group(jd, Config) ->
    ok = application:stop(jobdistributerl);
end_per_group(_, _Config) ->
    ok.
