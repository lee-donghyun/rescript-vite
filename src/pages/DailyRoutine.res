type routineHistory = {
  date: Js.Date.t,
  isDone: bool,
}

type routine = {
  title: string,
  id: float,
  history: array<routineHistory>,
}

type state = {
  list: array<routine>,
  text: string,
}

type action = Add | Input(string)

let reducer = (state, action) => {
  switch action {
  | Add => {
      text: "",
      list: state.list->Js.Array2.concat([
        {
          title: state.text,
          history: [],
          id: Js.Date.now(),
        },
      ]),
    }
  | Input(text) => {
      ...state,
      text,
    }
  }
}

@react.component
let make = () => {
  let (state, dispatch) = React_V3.useReducer(reducer, {list: [], text: ""})
  <div className="p-10">
    <h1 className="text-xl p-5 rounded shadow-inner">
      {"Rescript로 만든 데일리 루틴 앱"->React.string}
    </h1>
    <div className="p-5 flex gap-5">
      <input
        placeholder="여기에 추가할 루틴의 이름을 입력해보세요 ~"
        className="flex-1 p-2 border shadow-inner"
        value={state.text}
        onChange={e => e->FormUtil.text->Input->dispatch}
      />
      <button
        className="bg-blue-600 text-white p-3 rounded shadow-inner" onClick={_ => Add->dispatch}>
        {"추가"->React.string}
      </button>
    </div>
    <ul>
      {state.list
      ->Js.Array2.map(routine =>
        <li key={routine.id->Js.Float.toString}> {routine.title->React.string} </li>
      )
      ->React.array}
    </ul>
  </div>
}
