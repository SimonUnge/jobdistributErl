REBAR=`which rebar || ./rebar`

all: deps compile

deps:
	@$(REBAR) get-deps
compile:
	@$(REBAR) compile
tests: eunit ct

eunit:
	@$(REBAR) skip_deps=true eunit
ct:
	@$(REBAR) ct
dialyze:
	@dialyzer --src src/*.erl test/*.erl 

clean:
	@$(REBAR) clean
	@rm -r ebin/ || true
	@rm -r logs/ || true
	@rm test/*.beam || true
