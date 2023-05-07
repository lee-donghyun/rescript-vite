open RescriptStruct

type routineHistory = {
  daysFromStart: int,
  isDone: bool,
}
type routine = {
  title: string,
  id: float,
  startedAt: float,
  history: array<routineHistory>,
}
type state = {
  list: array<routine>,
  text: string,
  error: string,
}
type action = Add | Input(string)

let persistKey = "daily_routine"
let persistStruct = S.array(
  S.object(v => {
    title: v->S.field("title", S.string()),
    id: v->S.field("id", S.float()),
    startedAt: v->S.field("startedAt", S.float()),
    history: v->S.field(
      "history",
      S.array(
        S.object(v => {
          daysFromStart: v->S.field("daysFromStart", S.int()),
          isDone: v->S.field("isDone", S.bool()),
        }),
      ),
    ),
  }),
)

let reducer = (state, action) => {
  let nextState = switch action {
  | Add =>
    state.text->Js.String.length > 0
      ? {
          error: "",
          text: "",
          list: state.list->Js.Array2.concat([
            {
              title: state.text,
              startedAt: Js.Date.now(),
              id: Js.Date.now(),
              history: [],
            },
          ]),
        }
      : {
          ...state,
          error: "한 글자 이상 입력해주세요.",
        }
  | Input(text) => {
      ...state,
      error: "",
      text,
    }
  }
  ignore(nextState.list->Persist.write(persistStruct, persistKey))
  nextState
}

@react.component
let make = () => {
  let (state, dispatch) = React_V3.useReducerWithMapState(reducer, (), _ =>
    Persist.read([], persistStruct, persistKey)->(list => {list, text: "", error: ""})
  )
  <div className="p-10">
    <h1 className="text-xl p-5 rounded shadow-inner">
      {"Rescript로 만든 데일리 루틴 앱"->React.string}
    </h1>
    <form
      className="p-5 flex gap-5"
      onSubmit={e => {
        e->FormUtil.preventDefault
        Add->dispatch
      }}>
      <input
        placeholder="여기에 추가할 루틴의 이름을 입력해보세요 ~"
        className="flex-1 p-2 border shadow-inner"
        value={state.text}
        onChange={e => e->FormUtil.text->Input->dispatch}
      />
      <button className="bg-blue-600 text-white p-3 rounded shadow-inner">
        {"추가"->React.string}
      </button>
    </form>
    {state.error->Js.String.length > 0
      ? <p className="text-red-500"> {state.error->React.string} </p>
      : React.null}
    <ul>
      {state.list
      ->Js.Array2.map(routine =>
        <li key={routine.id->Js.Float.toString} className="list-disc">
          <Anchor
            className="text-lg font-bold p-3 hover:opacity-70 duration-300"
            to={`/daily-routine/${routine.id->Js.Float.toString}`}>
            {routine.title->React.string}
          </Anchor>
        </li>
      )
      ->React.array}
    </ul>
  </div>
}
