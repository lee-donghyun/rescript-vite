type todo = {id: float, text: string}
type state = {list: array<todo>}
type action = Add | Delete(float) | Input(float, string)

let reducer = (state, action) => {
  switch action {
  | Add => {
      list: state.list->Js.Array.concat([
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
  <div> {"Hello world"->React.string} </div>
}
