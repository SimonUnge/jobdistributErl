-module(jd_decode).
-include("include/jobdist.hrl").
-export([
        decode/1
        ]).

decode({}) ->
    not_valid_jd;
decode({FieldList}) ->
    decode(FieldList,#job_document{}).

decode([], JDRec) ->
    JDRec;
decode([H|T], JDRec) ->
    UpdatedJDRec = case binary_to_list(element(1,H)) of
                       "_id" ->
                           JDRec#job_document{id = binary_to_list(element(2,H))}
                   end,
    decode(T, UpdatedJDRec).



