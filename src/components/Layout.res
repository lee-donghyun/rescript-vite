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
    <main> {children} </main>
    <footer> {"Rescript 한번 잡솨바!"->React.string} </footer>
  </div>
}
