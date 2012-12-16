-module(jd_workmanager).
-include("include/jobdist.hrl").
-behaviour(gen_server).

%% API
-export([start_link/0
         ,get_job/1
        ]).

%% Internals
-export([extract_job/1
         ,create_executing_worker/1
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

get_job(JobDoc) ->
    gen_server:call(?MODULE,{job,JobDoc}).

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

init([]) ->
    {ok, #state{}}.

handle_call({job,JobDoc}, _From, State) ->
    JobWithExecutioner = create_executing_worker(extract_job(JobDoc)),
    Reply = JobDoc#job_document{job = JobWithExecutioner},
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


extract_job(JobDoc) ->
    JobDoc#job_document.job.

create_executing_worker(Job) ->
    WorkerPid = spawn(worker, execute_job, [Job]),
    Job#job{executioner = WorkerPid}.
