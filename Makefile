REBAR=`which rebar || ./rebar`

all: deps compile

deps:
	@$(REBAR) get-deps

compile:
	@$(REBAR) compile

tests:
	@$(REBAR) skip_deps=true eunit

clean:
	@$(REBAR) clean
