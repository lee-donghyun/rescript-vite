@react.component
let make = (~children: Jsx.element, ~to: string, ~className: string) => {
  <a
    className
    href={to}
    onClick={e => {
      ReactEvent_V3.Mouse.preventDefault(e)
      RescriptReactRouter.push(to)
    }}>
    {children}
  </a>
}
