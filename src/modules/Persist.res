open RescriptStruct

let write = (state: 'a, struct: S.t<'a>, key) => {
  try {
    Dom.Storage2.localStorage->Dom.Storage2.setItem(key, struct->Json.serialize(state))
  } catch {
  | _ => ignore()
  }
  state
}
let read = (default, struct: S.t<'a>, key) => {
  switch Dom.Storage2.localStorage->Dom.Storage2.getItem(key) {
  | Some(json) => struct->Json.parse(json, default)
  | None => default
  }
}
