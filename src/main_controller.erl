-module(main_controller).

-export([index/1,new/1,create/1]).
-export([handle_request/2, before_filter/1]).

-behaviour(gen_controller).

-include("beepbeep.hrl").

%% Called by / Or /main
index(Params) ->
    gen_controller:call(?MODULE,index,Params).

%% Called by /main/new
new(Params) ->
    gen_controller:call(?MODULE,new,Params).

%% Called /main/create
create(Params) ->
    gen_controller:call(?MODULE,create,Params).

%% Pull the latest post from the DB, pass to the 
%% template, and return the index.html
handle_request(index,Params) ->
    D = blog_database:latest(),
    {render, "main/index.html",[{data,D}],Params};

%% Return the new.html template
handle_request(new,Params) ->
    {render, "main/new.html",[],Params};

%% Create a new Post.
handle_request(create,Params) ->
    %% Pull the post parameters
    Title = beepbeep_api:get_param(Params,"post_title"),
    Body = beepbeep_api:get_param(Params,"post_body"),
    %% Save to the database and redirect to the /
    blog_database:insert(Title,Body),
    {redirect,"/"}.

%% Callback for authentication
%% Checks the user has logged in by looking for the 'user_id' flag
%% in the session. In this case we only apply the filter to requests
%% made on /main/new and main/create.  Requests to index are NOT
%% blocked/checked 
before_filter(Params) ->
    FilterOnly = [new,create],
    case lists:member(Params#params.action,FilterOnly) of
	true ->
	    case beepbeep_api:get_session(Params,"user_id") of
		undefined ->
		    {redirect,"/login/new"};
		_A -> {ok}
	    end;
	false ->
	    {ok}
    end.
	    



