%%raw("import './index.css'")

ignore(
  ReactDOM.querySelector("#root")->Belt.Option.map(root =>
    root->ReactDOM.Client.createRoot->ReactDOM.Client.Root.render(<App />)
  ),
)
