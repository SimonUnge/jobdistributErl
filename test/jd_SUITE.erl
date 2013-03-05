-module(jd_SUITE).

-include_lib("common_test/include/ct.hrl").

-export([all/0, groups/0, init_per_group/2, end_per_group/2]).
-export([
         send_invalid_job_recv_error/1,
         send_echo_job_recv_ok/1,
         send_valid_job_and_ask_for_result/1,
         send_valid_long_job_and_ask_for_result/1,
         send_invalid_job_and_ask_for_result/1
        ]).

all() ->
    [{group, jd_give_job},
     {group, jd_give_job_recv_status}].

groups() ->
    [
     {jd_give_job,
      [],
      [send_invalid_job_recv_error,
       send_echo_job_recv_ok
      ]
     },
     {jd_give_job_recv_status,
      [],
      [send_valid_job_and_ask_for_result,
       send_valid_long_job_and_ask_for_result,
       send_invalid_job_and_ask_for_result]}
    ].


send_invalid_job_recv_error(_Config) ->
    Command = not_a_string,
    error = job:create(Command).

send_echo_job_recv_ok(_Config) ->
    Command = "echo hello",
    ok = jd_manager:give_job(job:create(Command)).

send_valid_job_and_ask_for_result(_Config) ->
    Command = "echo hello",
    Job = job:create(Command),
    SuccessStaus = 0,
    ok = jd_manager:give_job(Job),
    SuccessStaus = jd_manager:get_job_result(Job).

send_valid_long_job_and_ask_for_result(_Config) ->
    Command = "sleep 1",
    Job = job:create(Command),
    SuccessStaus = 0,
    ok = jd_manager:give_job(Job),
    SuccessStaus = jd_manager:get_job_result(Job).

send_invalid_job_and_ask_for_result(_Config) ->
    Command = "invalid_job",
    Job = job:create(Command),
    ok = jd_manager:give_job(Job),
    0 =/= jd_manager:get_job_result(Job).

init_per_group(jd_give_job, Config) ->
    start_app_return_config(Config);
init_per_group(jd_give_job_recv_status, Config) ->
    start_app_return_config(Config);
init_per_group(_, Config) ->
    Config.

end_per_group(jd_give_job, Config) ->
    stop_app();
end_per_group(jd_give_job_recv_status, Config) ->
    stop_app();
end_per_group(_, _Config) ->
    ok.

start_app_return_config(Config) ->
    ok = application:start(jobdistributerl),
    Config.    

stop_app() ->
    ok = application:stop(jobdistributerl).
