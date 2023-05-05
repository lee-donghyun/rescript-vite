let fromOption = option => {
  switch option {
  | Some(data) => Belt.Result.Ok(data)
  | None => Belt.Result.Error()
  }
}

let fromResult = result => {
  switch result {
  | Belt.Result.Ok(data) => Some(data)
  | Belt.Result.Error(_) => None
  }
}
