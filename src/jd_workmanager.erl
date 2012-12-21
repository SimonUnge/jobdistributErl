-module(jd_workmanager).
-include("include/jobdist.hrl").
-behaviour(gen_server).

%% API
-export([start_link/0
         ,give_job/1
        ]).

%% Internals
-export([
         create_executing_worker/1
        ]).
%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

-define(SERVER, ?MODULE). 

-record(state, {}).

%%%===================================================================
%%% API
%%%===================================================================


start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

give_job(JobDoc) ->
    gen_server:call(?MODULE,{job,JobDoc}).

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

init([]) ->
    {ok, #state{}}.

handle_call({job,JobDoc}, _From, State) ->
    Reply = create_executing_worker(JobDoc),
    {reply, Reply, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.


handle_info(_Info, State) ->
    {noreply, State}.


terminate(_Reason, _State) ->
    ok.


code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================

create_executing_worker(JobDoc) ->
    JobDo = jobdocumenthandler:extract_do(JobDoc),
    Executioner = spawn(worker, execute_job, [JobDo]),
    jobdocumenthandler:set_executioner(JobDoc, Executioner).
