let text = e => ReactEvent.Form.currentTarget(e)["value"]
let checked = e => ReactEvent.Form.currentTarget(e)["checked"]
let preventDefault = e => e->ReactEvent.Form.preventDefault
