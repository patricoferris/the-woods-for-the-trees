open Geojsone

let point_to_csv = function
  | G.Geometry.Point p ->
    let pos = G.Geometry.Point.position p  in
    let long = G.Geometry.Position.lng pos in
    let lat = G.Geometry.Position.lat pos in
    Fmt.pr "A,%.12f,%.12f\n" long lat
  | _ -> ()

let () =
  let json =
    In_channel.with_open_text "./random-points.json" @@ fun ic ->
    In_channel.input_all ic
  in
  let ez = Ezjsone.from_string json in
  let geo = G.of_json ez |> Result.get_ok in
  let fc = G.geojson geo |> function G.FeatureCollection fc -> fc | _ -> assert false in
  let fs = G.Feature.Collection.features fc in
  let geo = List.filter_map G.Feature.geometry fs |> List.map G.Geometry.geometry in
  List.iter point_to_csv geo