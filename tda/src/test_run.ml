open Request
open Core
open Async

let () =
  let uri = Request.api_options `GET_QUOTES in
  let cons_key = (fun (k,_) ->
      sprintf "%s@AMER.OAUTHAP" k)
      (Credentials.read_credentials "credentials.json") in
  let header = (fun (j,_,_) ->
      sprintf "Bearer %s" j)
      (Credentials.read_tokens "tokens.json") in
  let body = [("apikey", [cons_key]);
              ("symbol", ["AAPL"])
             ] in
  let make = make_client_req ~uri:uri ~body:body ~headers:[("Authorization", header)]
  in
  