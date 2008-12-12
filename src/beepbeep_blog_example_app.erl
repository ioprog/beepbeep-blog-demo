%% @author author <author@example.com>
%% @copyright YYYY author.

%% @doc Callbacks for the beepbeep_blog_example application.

-module(beepbeep_blog_example_app).
-author('author <author@example.com>').

-behaviour(application).
-export([start/2,stop/1]).


%% @spec start(_Type, _StartArgs) -> ServerRet
%% @doc application start callback for beepbeep_blog_example.
start(_Type, _StartArgs) ->
    beepbeep_blog_example_deps:ensure(),
    beepbeep_blog_example_sup:start_link().

%% @spec stop(_State) -> ServerRet
%% @doc application stop callback for beepbeep_blog_example.
stop(_State) ->
    ok.
