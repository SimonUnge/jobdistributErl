-module(jd_workmanager).
-behaviour(gen_server).

%% API
-export([start_link/0
         ,give_job/1
	 ,get_node_name/0
	 ,set_node_name/1
        ]).

%% Internals
-export([
         create_executing_worker/1
        ]).
%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

-define(SERVER, ?MODULE). 

-record(state, {node_name}).

%%%===================================================================
%%% API
%%%===================================================================


start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

give_job(JobDoc) ->
    gen_server:call(?MODULE,{job,JobDoc}).

set_node_name(Name) ->
    gen_server:call(?MODULE,{set_node_name, Name}).

get_node_name() ->
    gen_server:call(?MODULE,get_node_name).
%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

init([]) ->
    {ok, #state{}}.

handle_call({job,JobDoc}, _From, State) ->
    Reply = case job_is_claimed(JobDoc) of
		true ->
		    create_executing_worker(JobDoc);
		false ->
		    claim_job(State#state.node_name, JobDoc)
	    end,
    {reply, Reply, State};

handle_call(get_node_name, _From, State) ->
    {reply, State#state.node_name, State};

handle_call({set_node_name, Name}, _From, State) ->
    {reply, ok, State#state{node_name = Name}}.

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
    jobdocumenthandler:set_executioner(Executioner, JobDoc).

job_is_claimed(JobDoc) ->
    jobdocumenthandler:extract_claimed_by(JobDoc) =/= "".

claim_job(Claimer, JobDoc) ->
    jobdocumenthandler:set_claimed_by(Claimer, JobDoc).
