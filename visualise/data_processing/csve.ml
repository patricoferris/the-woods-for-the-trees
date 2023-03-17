open Eio

let flow_to_in_obj_channel flow : Csv.in_obj_channel = object
  method close_in () = Flow.close flow

  (* Blergh copying... *)
  method input bs off len =
    let buf = Cstruct.create len in
    let i = Flow.single_read flow buf in
    Cstruct.blit_to_bytes buf 0 bs off i;
    i
end

let with_file path fn =
  Path.with_open_in path @@ fun flow ->
  fn (Csv.of_in_obj @@ flow_to_in_obj_channel flow)

