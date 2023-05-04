type todo = {id: float, text: string}
type state = {list: array<todo>}
type action = Add | Delete(float) | Input(float, string)

let reducer = (state, action) => {
  switch action {
  | Add => {
      list: state.list->Js.Array2.concat([
        {
          id: Js.Date.now(),
          text: "",
        },
      ]),
    }
  | Delete(id) => {
      list: state.list->Js.Array2.filter(todo => todo.id != id),
    }
  | Input(id, text) => {
      list: state.list->Js.Array2.map(todo => todo.id == id ? {id, text} : todo),
    }
  }
}

@react.component
let make = () => {
  let (state, dispatch) = React.useReducer(reducer, {list: []})
  <div>
    <h1> {"Rescript로 만든 todo 앱"->React.string} </h1>
    <div>
      <button
        onClick={_ => {
          dispatch(Add)
        }}>
        {"추가"->React.string}
      </button>
    </div>
    {state.list
    ->Js.Array2.map(todo =>
      <li key={todo.id->Js.Float.toString}>
        <input
          value={todo.text}
          onChange={e => {
            Input(todo.id, e->FormUtil.text)->dispatch
          }}
        />
      </li>
    )
    ->React.array}
  </div>
}
