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
    Reply = handle_incoming_jd(JobDoc, State),
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

handle_incoming_jd(JobDoc, State) ->
    io:format(user, "JobDoc: ~p", [JobDoc]),
    case action_to_take(JobDoc, State) of 
        claim ->
            claim_job(State#state.node_name, JobDoc);
        won ->
            create_executing_worker(JobDoc);
        _ ->
            JobDoc
    end.

action_to_take(JobDoc, State) ->
    ClaimFuns = claim_predicate_funs(),
    WonFuns = won_predicate_funs(),
    case predicate:check(ClaimFuns, JobDoc) of
        passed ->
            claim;
        error ->
            case predicate:check(WonFuns, JobDoc) of
                passed ->
                    won;
                error ->
                    error
            end
    end.

claim_predicate_funs() ->
    [fun is_not_claimed/1].
                
won_predicate_funs() ->
    [fun is_winner/1].

create_executing_worker(JobDoc) ->
    JobDo = jobdocumenthandler:extract_do(JobDoc),
    Executioner = spawn(worker, execute_job, [JobDo]),
    jobdocumenthandler:set_executioner(Executioner, JobDoc).

is_not_claimed(JobDoc) ->
    jobdocumenthandler:extract_claimed_by(JobDoc) =:= "".

is_winner(JobDoc) ->
    jobdocumenthandler:extract_winner(JobDoc) =:= jd_workmanager:get_node_name().

claim_job(Claimer, JobDoc) ->
    jobdocumenthandler:set_claimed_by(Claimer, JobDoc).

