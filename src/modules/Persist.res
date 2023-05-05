open RescriptStruct

let write = (state, struct, key) => {
  ignore(
    state
    ->S.serializeToJsonWith(struct)
    ->Belt.Result.map(json => Dom.Storage2.localStorage->Dom.Storage2.setItem(key, json)),
  )
  state
}
let read = (default, struct: S.t<'a>, key) => {
  Dom.Storage2.localStorage
  ->Dom.Storage2.getItem(key)
  ->Belt.Option.flatMap(json => json->S.parseJsonWith(struct)->Bind.fromResult)
  ->Belt.Option.getWithDefault(default)
}
