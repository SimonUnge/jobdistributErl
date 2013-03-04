-module(jd_manager).

-behaviour(gen_server).

%% API
-export([
         start_link/0
         ,give_job/1
         ,get_job_result/1
         ,job_result/2
        ]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

-define(SERVER, ?MODULE). 

-record(state, {executed_jobs, awaiting_job_status}).

%%%===================================================================
%%% API
%%%===================================================================

start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

give_job(Job) ->
    gen_server:call(?MODULE,{job,Job}).

get_job_result(JobId) ->
    gen_server:call(?MODULE, {get_job_result, JobId}).

job_result(Status, JobId) ->
    gen_server:cast(?MODULE,{job_status, {Status, JobId}}).
%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

init([]) ->
    {ok, 
     #state{executed_jobs = jd_store:create_executed_jobs_db(),
            awaiting_job_status = jd_store:create_awaiting_job_status_db()
           }
    }.

handle_call({job, Job}, _From, State) ->
    Reply = jd_manager_lib:handle_job(Job),
    {reply, Reply, State};
handle_call({get_job_result, JobId}, From, State) ->
    case jd_manager_lib:is_job_executed(State#state.executed_jobs, JobId) of
        false ->
            jd_store:insert(State#state.awaiting_job_status, JobId, From),
            {noreply, State};
        true ->
            Reply = jd_store:lookup(State#state.executed_jobs, JobId),
            {reply, Reply, State}
    end.

handle_cast({job_status, {Status, JobId}}, State) ->
    case jd_manager_lib:is_someone_waiting_for_job(State#state.awaiting_job_status, JobId) of
        false ->
            jd_store:insert(State#state.executed_jobs, JobId, Status);
        true ->
            From = jd_store:lookup(State#state.awaiting_job_status, JobId),
            jd_store:delete(State#state.awaiting_job_status, JobId),
            gen_server:reply(From, Status)
    end,
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.
