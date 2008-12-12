%% @author author <author@example.com>
%% @copyright YYYY author.

%% @doc TEMPLATE.

-module(beepbeep_blog_example).
-author('author <author@example.com>').
-export([start/0, stop/0]).

ensure_started(App) ->
    case application:start(App) of
        ok ->
            ok;
        {error, {already_started, App}} ->
            ok
    end.
        
%% @spec start() -> ok
%% @doc Start the beepbeep_blog_example server.
start() ->
    beepbeep_blog_example_deps:ensure(),
    ensure_started(crypto),
    application:start(beepbeep_blog_example).

%% @spec stop() -> ok
%% @doc Stop the beepbeep_blog_example server.
stop() ->
    Res = application:stop(beepbeep_blog_example),
    application:stop(crypto),
    Res.
