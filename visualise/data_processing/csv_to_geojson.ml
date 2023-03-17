open Eio
module Geojson = Geojsone.G

let (/) = Path.(/)

let row_to_geojson s =
  let open Geojson in
  let (lng, lat) = List.nth s 0 |> Wkte.decode_point in
  let id = List.nth s 1 in
  let pos = Geometry.Position.v ~lng ~lat () in
  let geo = Geometry.(v @@ Point (Geometry.Point.v pos)) in
  Feature.v ~properties:(`O [ "id", `String id ]) geo

let main fs stdout =
  Csve.with_file (fs / Sys.argv.(1)) @@ fun ic ->
  (* Ignore the header... *)
  ignore (Csv.next ic);
  let features = Csv.fold_left ~f:(fun acc row -> row_to_geojson row :: acc) ~init:[] ic in
  let features = List.filteri (fun i _ -> i < 10_000) features in
  let geojson = Geojson.(v @@ FeatureCollection (Feature.Collection.v features)) in
  Flow.copy_string "const data = " stdout;
  Flow.copy_string (Geojsone.Ezjsone.to_string @@ Geojson.to_json geojson) stdout

let () =
  Eio_main.run @@ fun env ->
  main env#fs env#stdout
