open RescriptStruct
open Belt.Result

let serialize = (struct: S.t<'a>, state) =>
  switch state->S.serializeToJsonWith(struct) {
  | Ok(json) => json
  | Error(_) => Js.Exn.raiseError("failed to serialize data")
  }

let parse = (struct: S.t<'a>, json, default) =>
  switch json->S.parseJsonWith(struct) {
  | Ok(state) => state
  | Error(_) => default
  }
