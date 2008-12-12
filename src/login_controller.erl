-module(login_controller).

-export([new/1,create/1]).
-export([handle_request/2, before_filter/1]).

-behaviour(gen_controller).

-include("beepbeep.hrl").

%% Called by /login/new
new(Params) ->
    gen_controller:call(?MODULE,new,Params).

%% Called by /login/create
create(Params) ->
    gen_controller:call(?MODULE,create,Params).


%% Simply returns the new.html template for login
handle_request(new,Params) ->
    {render, "login/new.html",[],Params};

%% Handles the login attempt
handle_request(create,Params) ->
    %% Extract the post parameters from the request
    Un = beepbeep_api:get_param(Params,"un"),
    Pw = beepbeep_api:get_param(Params,"pw"),

    %% Check if the user entered the proper Username and Password. 
    %% In this case it's hard code - foo:foobar
    case Un =:= "foo" andalso Pw =:= "foobar" of
	true ->
	    %% If the user entered the correct Un/Pw
	    %% Set the user_id in the session and redirect
	    beepbeep_api:set_session(Params,"user_id","dave"),
	    {redirect,"/main/new"};
	false ->
	    %% Bad username and password and redirect back to
	    %% login page
	    {redirect,"/login/new"}
    end.

before_filter(Params) ->
    {ok}.
