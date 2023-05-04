@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()
  <Layout>
    {switch url.path {
    | list{"todo"} => <TodoPage />
    | _ => "Home"->React.string
    }}
  </Layout>
}
