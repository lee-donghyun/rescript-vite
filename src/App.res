@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()
  <Layout>
    {switch url.path {
    | list{"todo"} => <TodoPage />
    | list{"daily-routine"} => <DailyRoutine />
    | _ => "Home"->React.string
    }}
  </Layout>
}
