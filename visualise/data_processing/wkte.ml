open Eio

let src_of_flow (flow : #Flow.source) =
  let buff = Cstruct.create 2048 in
  fun () ->
    try
      let got = Eio.Flow.single_read flow buff in
      let t = Some (Cstruct.to_bytes buff, 0, got) in
      t
    with End_of_file -> None

let of_string s = src_of_flow (Flow.string_source s)

let pp_lexeme ppf = function
  | `Lexeme `Po -> Fmt.string ppf "("
  | `Lexeme `Pc -> Fmt.string ppf ")"
  | `Lexeme `Comma -> Fmt.string ppf ","
  | `Lexeme (`Number f) -> Fmt.float ppf f
  | _ -> Fmt.string ppf "Unknown"

let ignore_lexeme l l' =
  if l <> l' then (Fmt.failwith "Failure: %a <> %a" pp_lexeme l pp_lexeme l')

let decode_point s =
  let src = of_string s in
  let decoder = Wkt.decoder src in
  let rec loop acc = match Wkt.decode decoder with
    | `Lexeme (`Geometry "POINT") -> (
      ignore_lexeme (`Lexeme `Po) (Wkt.decode decoder);
      let lat = Wkt.decode decoder in
      let lng = Wkt.decode decoder in
      ignore_lexeme (`Lexeme `Pc) (Wkt.decode decoder);
      match lat, lng with
        | `Lexeme (`Number f1), `Lexeme (`Number f2) -> loop (Some f1, Some f2)
        | _ -> failwith "Failed to parse point!"
    )
    | `End -> Option.get (fst acc), Option.get (snd acc)
    | _ -> loop acc
  in
  loop (None, None)
