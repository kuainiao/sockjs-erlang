-module(sockjs).

-export([send/2, close/1, close/3]).

-type(conn() :: {sockjs_session | sockjs_ws, any()}).

%% Send data over a connection.
-spec send(iodata(), conn()) -> ok.
send(Data, Conn = {sockjs_session, _}) ->
    sockjs_session:send(Data, Conn);
send(Data, Conn = {sockjs_ws, _}) ->
    sockjs_ws:send(Data, Conn).

%% Initiate a close of a connection.
-spec close(conn()) -> ok.
close(Conn) ->
    close(1000, "Normal closure", Conn).

-spec close(non_neg_integer(), string(), conn()) -> ok.
close(Code, Reason, Conn = {sockjs_session, _}) ->
    sockjs_session:close(Code, Reason, Conn);
close(Code, Reason, Conn = {sockjs_ws, _}) ->
    sockjs_ws:close(Code, Reason, Conn).