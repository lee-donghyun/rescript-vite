type todo = {id: float, text: string, checked: bool}
type state = {list: array<todo>}
type action = Add | Delete(float) | Input(float, string) | Toggle(float, bool)

module Json = {
  open RescriptStruct
  open Belt.Result
  let stateStruct = S.object(v => {
    list: v->S.field(
      "list",
      S.array(
        S.object(v => {
          id: v->S.field("id", S.float()),
          text: v->S.field("text", S.string()),
          checked: v->S.field("checked", S.bool()),
        }),
      ),
    ),
  })
  let serialize = state =>
    switch state->S.serializeToJsonWith(stateStruct) {
    | Ok(json) => json
    | Error(_) => Js.Exn.raiseError("failed to serialize data")
    }
  let parse = (json, default) =>
    switch json->S.parseJsonWith(stateStruct) {
    | Ok(state) => state
    | Error(_) => default
    }
}

module Persist = {
  let key = "todo_list"
  let default = {list: []}
  let write = state => {
    try {
      Dom.Storage2.localStorage->Dom.Storage2.setItem(key, Json.serialize(state))
    } catch {
    | _ => ignore()
    }
    state
  }
  let read = () => {
    switch Dom.Storage2.localStorage->Dom.Storage2.getItem(key) {
    | Some(json) => Json.parse(json, default)
    | None => default
    }
  }
}

let reducer = (state, action) => {
  switch action {
  | Add => {
      list: state.list->Js.Array2.concat([
        {
          id: Js.Date.now(),
          text: "",
          checked: false,
        },
      ]),
    }
  | Delete(id) => {
      list: state.list->Js.Array2.filter(todo => todo.id != id),
    }
  | Input(id, text) => {
      list: state.list->Js.Array2.map(todo => todo.id == id ? {...todo, text} : todo),
    }
  | Toggle(id, checked) => {
      list: state.list->Js.Array2.map(todo => todo.id == id ? {...todo, checked} : todo),
    }
  }->Persist.write
}

@react.component
let make = () => {
  let (state, dispatch) = React.useReducerWithMapState(reducer, (), () => Persist.read())

  <div className="p-10">
    <h1 className="text-xl p-5 rounded shadow-inner">
      {"Rescript로 만든 todo 앱"->React.string}
    </h1>
    <div className="p-5">
      <button
        className="bg-blue-600 text-white p-3 rounded shadow-inner"
        onClick={_ => {
          dispatch(Add)
        }}>
        {"추가"->React.string}
      </button>
    </div>
    <ul className="p-5">
      {state.list
      ->Js.Array2.map(todo =>
        <li key={todo.id->Js.Float.toString} className="mb-5 flex items-center">
          <input
            type_="checkbox"
            checked={todo.checked}
            onChange={e => {
              Toggle(todo.id, e->FormUtil.checked)->dispatch
            }}
            className="mr-5"
          />
          <input
            value={todo.text}
            placeholder="여기에 입력하세요!"
            className="flex-1"
            onChange={e => {
              Input(todo.id, e->FormUtil.text)->dispatch
            }}
          />
        </li>
      )
      ->React.array}
    </ul>
  </div>
}
