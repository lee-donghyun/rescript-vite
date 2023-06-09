type route = {path: string, title: string}

let routes = [
  {
    path: "/",
    title: "홈 페이지",
  },
  {
    path: "/todo",
    title: "투두리스트",
  },
  {
    path: "/daily-routine",
    title: "데일리 루틴 체크",
  },
]

@react.component
let make = (~children: Jsx.element) => {
  <div>
    <header>
      <nav className="p-5">
        <ul className="flex gap-5">
          {routes
          ->Js.Array2.map(route =>
            <li key={route.path}>
              <Anchor
                className="block p-5 bg-zinc-100 hover:bg-zinc-300 duration-200 hover:scale-110"
                to={route.path}>
                {route.title->React.string}
              </Anchor>
            </li>
          )
          ->React.array}
        </ul>
      </nav>
    </header>
    <main className="min-h-[calc(100vh-200px)]"> {children} </main>
    <footer className="bg-zinc-50 p-10"> {"Rescript 한번 잡솨바!"->React.string} </footer>
  </div>
}
